import CoolProp.CoolProp as CP

def getThVar(desired_var,first_var, first_var_value, second_var, second_var_value, fluid_name) :
    return CP.PropsSI(desired_var,  first_var, first_var_value, second_var, second_var_value, fluid_name)
