// Lean compiler output
// Module: SigmaR.Justifications.Core_Legitimacy.LegitimacyCharacterization
// Imports: public import Init public meta import Init public import SigmaR.Justifications.Core_Legitimacy.PFA_Justification public import SigmaR.Justifications.Core_Legitimacy.ContestationCondition_Justification public import SigmaR.Justifications.Core_Legitimacy.PublicFrameResolution_Justification public import SigmaR.Justifications.Core_Legitimacy.ScopeScaleRelativity_Justification public import SigmaR.Justifications.Core_Legitimacy.MultiScopeSimultaneity_Justification public import SigmaR.Justifications.Core_Legitimacy.TransitionCriteriaRerunnability_Justification public import SigmaR.Justifications.Core_Legitimacy.DerivedStanding_Justification public import SigmaR.Justifications.Core_Legitimacy.RiskIndexedStanding_Justification public import SigmaR.Justifications.Core_Legitimacy.CouplingExhaustiveness_Justification public import SigmaR.Justifications.Core_Legitimacy.CouplingTypeDifferentiation_Justification public import SigmaR.Justifications.Core_Legitimacy.DominantCoupling_Justification public import SigmaR.Justifications.Core_Legitimacy.BoundaryEnvelope_Justification public import SigmaR.Justifications.Core_Legitimacy.CIA_Justification
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
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_PFA__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_ContestationCondition__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_PublicFrameResolution__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_ScopeScaleRelativity__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_MultiScopeSimultaneity__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_TransitionCriteriaRerunnability__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_DerivedStanding__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_RiskIndexedStanding__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_CouplingExhaustiveness__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_CouplingTypeDifferentiation__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_DominantCoupling__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_BoundaryEnvelope__Justification(uint8_t builtin);
lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_CIA__Justification(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_LegitimacyCharacterization(uint8_t builtin) {
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
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_PFA__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_ContestationCondition__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_PublicFrameResolution__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_ScopeScaleRelativity__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_MultiScopeSimultaneity__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_TransitionCriteriaRerunnability__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_DerivedStanding__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_RiskIndexedStanding__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_CouplingExhaustiveness__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_CouplingTypeDifferentiation__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_DominantCoupling__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_BoundaryEnvelope__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_SigmaR_SigmaR_Justifications_Core__Legitimacy_CIA__Justification(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
