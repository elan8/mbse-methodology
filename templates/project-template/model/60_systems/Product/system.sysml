package Product {
    package Specification {
        part def ProductSpecification :> Elan8::SystemsEngineering::SystemSpecification {
            doc /* TODO: observable behavior, ports, properties, conditions and constraints.
                 * Explicitly assert applicable requirements here with `satisfy <requirement>;`
                 * so the owner/self binding and assertion are inherited by designs. */
        }
        package Requirements {
            doc /* TODO: stable IDs, explicit subjects/criteria and verification intent. */
        }
    }
    package Architecture {
        part def ProductArchitecture
            :> Specification::ProductSpecification, Elan8::SystemsEngineering::SystemArchitecture {
            doc /* TODO: child usages typed by contracts, interactions and responsibilities. */
        }
    }
    package Integration {
        part def ProductIntegration
            :> Architecture::ProductArchitecture, Elan8::SystemsEngineering::SystemIntegration {
            doc /* TODO: redefine child usages with selected compatible designs. */
        }
        part candidate : ProductIntegration;
    }
    package Analysis {
        doc /* TODO: feasibility, allocation rules, overhead, uncertainty and margin. */
    }
    package Verification {
        doc /* TODO: cases/objectives, configuration-specific executions and evidence. */
    }
    package Views {
        private import Elan8::SystemsEngineering::*;
        view specification : SpecificationView {
            expose Product::Specification::**;
        }
        view architecture : ArchitectureView {
            expose Product::Architecture::ProductArchitecture;
        }
        view integration : IntegrationView {
            expose Product::Integration::candidate;
        }
    }
}
