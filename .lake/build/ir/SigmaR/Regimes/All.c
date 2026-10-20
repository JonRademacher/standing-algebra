// Lean compiler output
// Module: SigmaR.Regimes.All
// Imports: public import Init public meta import Init public import SigmaR.Regimes.StandingAlgebra_AdapterRegime public import SigmaR.Regimes.StandingAlgebra_AffordanceCompositionRegime public import SigmaR.Regimes.StandingAlgebra_DriftRegime public import SigmaR.Regimes.StandingAlgebra_EmergencyRegime public import SigmaR.Regimes.StandingAlgebra_ExitRegime public import SigmaR.Regimes.StandingAlgebra_RegimesStacked public import SigmaR.Regimes.StandingAlgebra_RemedyRegime public import SigmaR.Regimes.StandingAlgebra_RiskRegime public import SigmaR.Regimes.StandingAlgebra_SuccessorRegime
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
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__AdapterRegime(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__AffordanceCompositionRegime(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__DriftRegime(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__EmergencyRegime(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__ExitRegime(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__RegimesStacked(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__RemedyRegime(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__RiskRegime(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__SuccessorRegime(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SigmaR_SigmaR_Regimes_All(uint8_t builtin) {
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
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__AdapterRegime(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__AffordanceCompositionRegime(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__DriftRegime(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__EmergencyRegime(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__ExitRegime(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__RegimesStacked(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__RemedyRegime(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Regimes_StandingAlgebra__RiskRegime(builtin);
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
