// Lean compiler output
// Module: SigmaR.ModelCollapseDemo
// Imports: public import Init public meta import Init
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
lean_object* l_Nat_add___boxed(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
static const lean_closure_object lp_SigmaR_ModelCollapseDemo_collapseModel___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)l_Nat_add___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_SigmaR_ModelCollapseDemo_collapseModel___closed__0 = (const lean_object*)&lp_SigmaR_ModelCollapseDemo_collapseModel___closed__0_value;
static const lean_ctor_object lp_SigmaR_ModelCollapseDemo_collapseModel___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 0}, .m_objs = {((lean_object*)&lp_SigmaR_ModelCollapseDemo_collapseModel___closed__0_value),((lean_object*)&lp_SigmaR_ModelCollapseDemo_collapseModel___closed__0_value)}};
static const lean_object* lp_SigmaR_ModelCollapseDemo_collapseModel___closed__1 = (const lean_object*)&lp_SigmaR_ModelCollapseDemo_collapseModel___closed__1_value;
LEAN_EXPORT const lean_object* lp_SigmaR_ModelCollapseDemo_collapseModel = (const lean_object*)&lp_SigmaR_ModelCollapseDemo_collapseModel___closed__1_value;
LEAN_EXPORT lean_object* lp_SigmaR_ModelCollapseDemo_distinctModel___lam__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR_ModelCollapseDemo_distinctModel___lam__0___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_SigmaR_ModelCollapseDemo_distinctModel___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_SigmaR_ModelCollapseDemo_distinctModel___lam__0___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_SigmaR_ModelCollapseDemo_distinctModel___closed__0 = (const lean_object*)&lp_SigmaR_ModelCollapseDemo_distinctModel___closed__0_value;
static const lean_ctor_object lp_SigmaR_ModelCollapseDemo_distinctModel___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 0}, .m_objs = {((lean_object*)&lp_SigmaR_ModelCollapseDemo_collapseModel___closed__0_value),((lean_object*)&lp_SigmaR_ModelCollapseDemo_distinctModel___closed__0_value)}};
static const lean_object* lp_SigmaR_ModelCollapseDemo_distinctModel___closed__1 = (const lean_object*)&lp_SigmaR_ModelCollapseDemo_distinctModel___closed__1_value;
LEAN_EXPORT const lean_object* lp_SigmaR_ModelCollapseDemo_distinctModel = (const lean_object*)&lp_SigmaR_ModelCollapseDemo_distinctModel___closed__1_value;
LEAN_EXPORT lean_object* lp_SigmaR_ModelCollapseDemo_distinctModel___lam__0(lean_object* v_a_5_, lean_object* v_s_6_){
_start:
{
lean_object* v___x_7_; lean_object* v___x_8_; lean_object* v___x_9_; 
v___x_7_ = lean_nat_add(v_a_5_, v_s_6_);
v___x_8_ = lean_unsigned_to_nat(1u);
v___x_9_ = lean_nat_add(v___x_7_, v___x_8_);
lean_dec(v___x_7_);
return v___x_9_;
}
}
LEAN_EXPORT lean_object* lp_SigmaR_ModelCollapseDemo_distinctModel___lam__0___boxed(lean_object* v_a_10_, lean_object* v_s_11_){
_start:
{
lean_object* v_res_12_; 
v_res_12_ = lp_SigmaR_ModelCollapseDemo_distinctModel___lam__0(v_a_10_, v_s_11_);
lean_dec(v_s_11_);
lean_dec(v_a_10_);
return v_res_12_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SigmaR_SigmaR_ModelCollapseDemo(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
lean_initialize_runtime_module();
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
