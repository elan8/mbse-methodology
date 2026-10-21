package ToolingRuleExamples {
    private import Elan8::SystemsEngineering::*;

    port def BoundaryPort;
    part def ChildSpecification :> SystemSpecification {
        port link : BoundaryPort;
    }
    part def ChildArchitecture :> ChildSpecification, SystemArchitecture;
    part def OtherSpecification :> SystemSpecification;

    part def ValidBB :> SystemSpecification {
        attribute limit : ScalarValues::Integer;
        port boundary : BoundaryPort;
    }
    part def InvalidBBWithPart :> SystemSpecification {
        part internal : ChildSpecification;
    }
    part def InvalidBBWithReference :> SystemSpecification {
        ref part external : ChildSpecification;
    }

    part def ValidGB :> ValidBB, SystemArchitecture {
        part child : ChildSpecification;
        connect boundary to child.link;
    }
    part def MissingContractGB :> SystemArchitecture;
    part def CompetingContractsGB :> ValidBB, OtherSpecification, SystemArchitecture;
    part def DesignTypedChildGB :> ValidBB, SystemArchitecture {
        part child : ChildArchitecture;
    }
    part def MarkerTypedChildGB :> ValidBB, SystemArchitecture {
        part child : SystemSpecification;
    }

    part def ValidWB :> ValidGB, SystemIntegration {
        part redefines child : ChildArchitecture;
    }
    part def PartialWB :> ValidGB, SystemIntegration;
    part def MissingArchitectureWB :> ValidBB, SystemIntegration;
    part def SpecificationSelectedWB :> ValidGB, SystemIntegration {
        part redefines child : ChildSpecification;
    }
    part def ExtraPartWB :> ValidWB {
        part extra : ChildArchitecture;
    }

    part def BranchSpecification :> SystemSpecification;
    part def BranchArchitecture :> BranchSpecification, SystemArchitecture {
        part leaf : ChildSpecification;
    }
    part def BranchIntegration :> BranchArchitecture, SystemIntegration {
        part redefines leaf : ChildArchitecture;
    }
    part def PartialBranchIntegration :> BranchArchitecture, SystemIntegration;
    part def OuterSpecification :> SystemSpecification;
    part def OuterArchitecture :> OuterSpecification, SystemArchitecture {
        part branch : BranchSpecification;
    }
    part def OuterWithGreyChild :> OuterArchitecture, SystemIntegration {
        part redefines branch : BranchArchitecture;
    }
    part def OuterWithPartialWhiteChild :> OuterArchitecture, SystemIntegration {
        part redefines branch : PartialBranchIntegration;
    }
    part def OuterComplete :> OuterArchitecture, SystemIntegration {
        part redefines branch : BranchIntegration;
    }
    part def OptionalArchitecture :> ValidBB, SystemArchitecture {
        part child[0..1] : ChildSpecification;
    }
    part def OptionalPartialWB :> OptionalArchitecture, SystemIntegration;
    part def AbsentChildWB :> OptionalArchitecture, SystemIntegration {
        part redefines child[0] : ChildSpecification;
    }
    part def OtherArchitecture :> ValidBB, SystemArchitecture {
        part other : ChildSpecification;
    }
    part def MultipleArchitecturesWB :> ValidGB, OtherArchitecture, SystemIntegration {
        part redefines child : ChildArchitecture;
        part redefines other : ChildArchitecture;
    }
    part def RecursiveSpecification :> SystemSpecification;
    part def RecursiveArchitecture :> RecursiveSpecification, SystemArchitecture {
        part next[0..1] : RecursiveSpecification;
    }
    part def RecursiveIntegration :> RecursiveArchitecture, SystemIntegration {
        part redefines next[0..1] : RecursiveIntegration;
    }

    part projectionSubject : ValidWB;
    view partsOnly : StandardViewDefinitions::GeneralView {
        expose ToolingRuleExamples::projectionSubject;
        filter @SysML::PartUsage;
        filter not @SysML::ConnectionUsage;
        filter not @SysML::ViewUsage;
    }

    doc /* Language-valid inputs, including intentional Elan8 method violations.
         * Expected method findings are in ../expected.json. The native language
         * checker does not implement the diagnostic contract. */
}
