#!/usr/bin/env python
"""
Zotero SQLite Access, v0.2
Author:     Rich Alesi
"""
import sqlite3 as sql
import types, codecs, re, os

# Change these two files to match your current database and storage directory
database = "C:/Users/yberton/Zotero/zotero.sqlite"
path = "C:/Users/yberton/Zotero/storage"

# Not implemented yet
moveAttach = True # specifies whether attachments are moved to different directory
attachdir = "F:\Documents\CMU\Research\attachments" # create this directory before running

class Table:
	def __init__(self, db, name):
		self.debug = 0
		self.db = db
		self.name = name
		self.dbc = self.db.cursor()
		self._search = ""
		self._sort = ""

	def __getitem__(self, item):
		q = "SELECT * FROM %s %s %s" % (self.name, self._search, self._sort)
		if isinstance(item, types.SliceType):
			q = q + " LIMIT %s, %s" % (item.start, item.stop - item.start)
			self._query(q)
			return self.dbc.fetchall()
		elif isinstance(item, types.IntType):
			q = q + " LIMIT %s, 1" % (item)
			self._query(q)
			return self.dbc.fetchone()
		else:
			raise IndexError 

	def __len__(self):
		self._query("SELECT COUNT(*) FROM %s %s" % (self.name, self._search))
		r = int(self.dbc.fetchone()[0])
		return r

	def _query(self, q, data=None):
		if data is None:
			if self.debug: print ("Query: %s" % (q))
			self.dbc.execute(q)
		else:
			if self.debug: print ("Query: %s %s" % (q, data))
			self.dbc.execute(q, data)

	def __iter__(self):
		"creates a data set, and returns an iterator (self)"
		q = "SELECT * FROM %s %s %s" % (self.name, self._search, self._sort)
		self._query(q)
		return self #iterator creates an object with a next() method

	def __delitem__(self, item):
		q = "SELECT * FROM %s %s %s limit %s, 1" % (self.name, self._search, self._sort, item)
		self._query(q)
		rid = self.dbc.fetchone()[0]
		try:
			q = "DELETE FROM %s where %s=%s" % (self.name, "itemID", rid)
			self._query(q)
		except:
			q = "DELETE FROM %s where %s=%s" % (self.name, "valueID", rid)
			self._query(q)

	def update(self, column, value):
		q = "UPDATE %s FROM"

	def next(self):
		"returns the next item in the data set, or tells Python to stop"
		r = self.dbc.fetchone()
		if not r:
			raise StopIteration
		return r

	def search(self, method):
		self._search = ""
		if method: self._search = "WHERE %s" % (method)

	def sort(self, method):
		self._sort = ""
		if method: self._sort = "ORDER BY %s" % (method)

	def insert(self, row):
		fmt = ("?," * len(row))[:-1]
		if len(self.name.split(',')) > 1:
			print ("Current cursor contains tables: %s, please select only one table" % (self.name))
		else:
			q = "INSERT INTO %s VALUES (%s)" % (self.name, fmt)
			self._query(q, row)


if __name__ == "__main__":
	db = sql.connect(database)

	# Initialize year database to only include first authors, journal articles, title fields, and attachments with pdf extension
	yeardb = Table(db, "itemData, itemDataValues, creators, itemCreators, itemAttachments, items")
	yeardb.search("creators.creatorID==itemCreators.creatorID AND itemCreators.orderIndex==0 AND items.itemID==itemAttachments.sourceItemID AND items.itemTypeID==4 AND itemCreators.itemID==itemAttachments.sourceItemID AND itemData.itemID==itemAttachments.sourceItemID AND itemData.valueID==itemDataValues.valueID AND itemData.fieldID==14 AND itemAttachments.mimeType=='application/pdf'")
	yeardb.sort("itemData.itemID")

    # Initialize item database to only include journal entires
	titledb = Table(db, "itemData, itemDataValues")
	titledb.search("itemData.valueID==itemDataValues.valueID AND itemData.fieldID==110")
	titledb.sort("itemData.itemID")

    # Initialize 2nd item database to only include file titles
	namedb = Table(db, "itemData, itemDataValues")
	valuedb = Table(db, "itemDataValues")
	attachdb = Table(db, "itemAttachments")

	db.commit()

	for b in yeardb:
		titledb.search("itemData.valueID==itemDataValues.valueID AND itemData.fieldID==110 AND itemData.itemID==%s" % (b[0]))
		c = titledb[0]

		# Get last name of 1st author
		author = b[7].encode('latin-1', 'replace')
		# Parse out 4 digit year
		year = re.findall("[0-9][0-9][0-9][0-9]",b[4].encode('latin-1', 'replace'))[0]
		# Parse out title
		title = c[4].encode('latin-1', 'replace')
		# Parse out attachment path
		curpath = path + "\\" + b[18].encode('latin-1', 'replace').replace("/","\\")
		pathpattern = re.compile(r'^(\d+)')
		# Parse out just the directory where the file is located
		curdir = pathpattern.search(b[18].encode('latin-1', 'replace')).groups()[0]
		# Capitalize Each Work In Sentence
		title = " ".join(a.capitalize() for a in title.split())
		# Truncate title if over 30 characters
		fulltitle = title
		if len(title) > 30:
			title = title[0:29].strip() + ".."
		# Compose new file path with parsed information
		newfile = curdir + "\\" + author + " (" + year + ") " + title + ".pdf"
		newfile = re.sub("[?:]+","_",newfile)
		newpath = path + "\\" + newfile

		# =============== Rename File =======================
		# Rename file
		os.system('copy "%s" "%s"' % (curpath, newpath))

		print ("File moved from %s to %s" % (curpath, newpath))

		# =============== Change attachement path in database =======================
		# Convert yeardb tuple into list
		newlist = list(b)
		# Replace path in yeardb list with new path
		newlist[18] = newfile.decode('latin-1').replace("\\", "/")
		# Create new tuple of just attachmentdb fields
		qrs = tuple(newlist[13:20])
		# Reduce database to search paramters (find attachment name)
		attachdb.search("itemAttachments.itemID==%s" % (qrs[0]))
		# Delete selected entry
		del attachdb[0]
		# Insert new tuple as entry
		attachdb.insert(qrs)

		# =============== Change file title in database =======================
		# Reduce database to search paramters (find attachment name)
		namedb.search("itemData.valueID==itemDataValues.valueID AND itemData.fieldID==110 AND itemData.itemID==%s" % (qrs[0]))
		oldvaldb = namedb[0][3:5]
		try:
			namedb.search("itemData.valueID==itemDataValues.valueID AND itemData.fieldID==12 AND itemData.itemID==%s" % (qrs[1]))
			repo = namedb[0][3:5]
			# Compose new title for attachment in zotero datbase
			newvalue = oldvaldb[0], year + " - " + repo[1]
		except:
			newvalue = oldvaldb[0], year + " - " + author

		print ('Attachment title is ' + newvalue)

		# Reduce database to search paramters (find value ID)
		valuedb.search("itemDataValues.valueID==%s" % (newvalue[0]))

		del valuedb[0]

		# Insert new tuple as entry
		valuedb.insert(newvalue)

	# Save changes to database
	yeardb.dbc.close()
	titledb.dbc.close()
	namedb.dbc.close()
	attachdb.dbc.close()
	valuedb.dbc.close()
	db.commit()

	exit()
