// Lean compiler output
// Module: SigmaR.Justifications.Regime_Legitimacy.SuccessorRegime.SuccessorSymmetry_Justification
// Imports: public import Init public meta import Init public import SigmaR.Justifications.Core_Legitimacy.STC5_Justification public import SigmaR.Regimes.StandingAlgebra_SuccessorRegime
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
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_STC5__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__SuccessorRegime(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SigmaR_SigmaR_Justifications_Regime__Legitimacy_SuccessorRegime_SuccessorSymmetry__Justification(uint8_t builtin) {
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
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_STC5__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__SuccessorRegime(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
