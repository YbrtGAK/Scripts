from math import pi
from CoolProp.CoolProp import PropsSI

def fun_test(a:float):
    return a*10*pi

def fun_test2(a:float,st:str):
    return [str(a) + st , str(a)]

def fun_test4(P:float):
    return PropsSI("T","P",P,"Q",1,"R245fa")

def props(desired_var:str,first_var:str,first_var_value:float,second_var:str,second_var_value:float,fluid_name:str):
    return PropsSI(desired_var,first_var,first_var_value,second_var,second_var_value,fluid_name)