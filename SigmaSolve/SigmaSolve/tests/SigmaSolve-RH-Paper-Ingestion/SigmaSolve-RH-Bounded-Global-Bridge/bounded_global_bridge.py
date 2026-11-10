def global_property(zeros):
    return all(z[2] for z in zeros)
def bounded_property(zeros,T):
    return all(on_line for _,im,on_line in zeros if abs(im)<=T)
def all_relevant_bounds(zeros):
    bounds=[1.0]+[abs(im)+1.0 for _,im,_ in zeros]
    return all(bounded_property(zeros,T) for T in bounds if T>0)
def bridge(zeros):
    return global_property(zeros)==all_relevant_bounds(zeros)
