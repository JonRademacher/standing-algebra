// Lean compiler output
// Module: SigmaR.Operations.AdmissibilityInvariant
// Imports: public import Init public meta import Init public import SigmaR.Core.FormalCore
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
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter___redArg(lean_object* v_x_1_, lean_object* v_x_2_, lean_object* v_x_3_, lean_object* v_h__1_4_, lean_object* v_h__2_5_){
_start:
{
lean_object* v_zero_6_; uint8_t v_isZero_7_; 
v_zero_6_ = lean_unsigned_to_nat(0u);
v_isZero_7_ = lean_nat_dec_eq(v_x_1_, v_zero_6_);
if (v_isZero_7_ == 1)
{
lean_object* v___x_8_; 
lean_dec(v_h__2_5_);
v___x_8_ = lean_apply_2(v_h__1_4_, v_x_2_, v_x_3_);
return v___x_8_;
}
else
{
lean_object* v_one_9_; lean_object* v_n_10_; lean_object* v___x_11_; 
lean_dec(v_h__1_4_);
v_one_9_ = lean_unsigned_to_nat(1u);
v_n_10_ = lean_nat_sub(v_x_1_, v_one_9_);
v___x_11_ = lean_apply_3(v_h__2_5_, v_n_10_, v_x_2_, v_x_3_);
return v___x_11_;
}
}
}
LEAN_EXPORT lean_object* lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter___redArg___boxed(lean_object* v_x_12_, lean_object* v_x_13_, lean_object* v_x_14_, lean_object* v_h__1_15_, lean_object* v_h__2_16_){
_start:
{
lean_object* v_res_17_; 
v_res_17_ = lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter___redArg(v_x_12_, v_x_13_, v_x_14_, v_h__1_15_, v_h__2_16_);
lean_dec(v_x_12_);
return v_res_17_;
}
}
LEAN_EXPORT lean_object* lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter(lean_object* v_motive_18_, lean_object* v_x_19_, lean_object* v_x_20_, lean_object* v_x_21_, lean_object* v_h__1_22_, lean_object* v_h__2_23_){
_start:
{
lean_object* v_zero_24_; uint8_t v_isZero_25_; 
v_zero_24_ = lean_unsigned_to_nat(0u);
v_isZero_25_ = lean_nat_dec_eq(v_x_19_, v_zero_24_);
if (v_isZero_25_ == 1)
{
lean_object* v___x_26_; 
lean_dec(v_h__2_23_);
v___x_26_ = lean_apply_2(v_h__1_22_, v_x_20_, v_x_21_);
return v___x_26_;
}
else
{
lean_object* v_one_27_; lean_object* v_n_28_; lean_object* v___x_29_; 
lean_dec(v_h__1_22_);
v_one_27_ = lean_unsigned_to_nat(1u);
v_n_28_ = lean_nat_sub(v_x_19_, v_one_27_);
v___x_29_ = lean_apply_3(v_h__2_23_, v_n_28_, v_x_20_, v_x_21_);
return v___x_29_;
}
}
}
LEAN_EXPORT lean_object* lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter___boxed(lean_object* v_motive_30_, lean_object* v_x_31_, lean_object* v_x_32_, lean_object* v_x_33_, lean_object* v_h__1_34_, lean_object* v_h__2_35_){
_start:
{
lean_object* v_res_36_; 
v_res_36_ = lp_SigmaR___private_SigmaR_Operations_AdmissibilityInvariant_0__SigmaR_iterApply_match__1_splitter(v_motive_30_, v_x_31_, v_x_32_, v_x_33_, v_h__1_34_, v_h__2_35_);
lean_dec(v_x_31_);
return v_res_36_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Core_FormalCore(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SigmaR_SigmaR_Operations_AdmissibilityInvariant(uint8_t builtin) {
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
res = initialize_SigmaR_SigmaR_Core_FormalCore(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
