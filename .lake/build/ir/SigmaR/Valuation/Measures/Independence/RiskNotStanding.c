// Lean compiler output
// Module: SigmaR.Valuation.Measures.Independence.RiskNotStanding
// Imports: public import Init public meta import Init public import SigmaR.StandingAlgebra_FormalCore public import SigmaR.Valuation.Core.StructuralInterfaces public import SigmaR.Valuation.Measures.RiskInheritance_Definition public import SigmaR.Valuation.Measures.StandingMeasure_Definition
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
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_StandingAlgebra__FormalCore(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Valuation_Core_StructuralInterfaces(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Valuation_Measures_RiskInheritance__Definition(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Valuation_Measures_StandingMeasure__Definition(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SigmaR_SigmaR_Valuation_Measures_Independence_RiskNotStanding(uint8_t builtin) {
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
res = initialize_SigmaR_SigmaR_StandingAlgebra__FormalCore(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Valuation_Core_StructuralInterfaces(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Valuation_Measures_RiskInheritance__Definition(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Valuation_Measures_StandingMeasure__Definition(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
