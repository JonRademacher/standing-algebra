// Lean compiler output
// Module: SigmaR.Valuation.Measures.Independence.ColllapseDemo
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
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR_CollapseDemo_StandingMeasure__model(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR_CollapseDemo_StandingMeasure__model___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR_CollapseDemo_RiskLoad__model(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR_CollapseDemo_RiskLoad__model___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR_CollapseDemo_StandingMeasure__model(lean_object* v_a_1_, lean_object* v_s_2_){
_start:
{
lean_object* v___x_3_; 
v___x_3_ = lean_nat_add(v_a_1_, v_s_2_);
return v___x_3_;
}
}
LEAN_EXPORT lean_object* lp_SigmaR_CollapseDemo_StandingMeasure__model___boxed(lean_object* v_a_4_, lean_object* v_s_5_){
_start:
{
lean_object* v_res_6_; 
v_res_6_ = lp_SigmaR_CollapseDemo_StandingMeasure__model(v_a_4_, v_s_5_);
lean_dec(v_s_5_);
lean_dec(v_a_4_);
return v_res_6_;
}
}
LEAN_EXPORT lean_object* lp_SigmaR_CollapseDemo_RiskLoad__model(lean_object* v_a_7_, lean_object* v_s_8_){
_start:
{
lean_object* v___x_9_; 
v___x_9_ = lean_nat_add(v_a_7_, v_s_8_);
return v___x_9_;
}
}
LEAN_EXPORT lean_object* lp_SigmaR_CollapseDemo_RiskLoad__model___boxed(lean_object* v_a_10_, lean_object* v_s_11_){
_start:
{
lean_object* v_res_12_; 
v_res_12_ = lp_SigmaR_CollapseDemo_RiskLoad__model(v_a_10_, v_s_11_);
lean_dec(v_s_11_);
lean_dec(v_a_10_);
return v_res_12_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SigmaR_SigmaR_Valuation_Measures_Independence_ColllapseDemo(uint8_t builtin) {
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
