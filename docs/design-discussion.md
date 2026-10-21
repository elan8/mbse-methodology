# Original methodology design discussion

Historical design input supplied for the restart. The [current handbook](../readme.md) defines the proposed method. Snippets here retain their original illustrative/unvalidated status.

The core concept of the Elan8 MBSE methodology is based on the ideas for Recursive System Decomposition using Black Box, Grey Box and White Box parts.
https://www.incose.org/wp-content/uploads/2026/10/A_SysML_V2_Modeling_Pattern_for_Recursive_System_Decompostion_Presentation.pdf
In the Elan8 methodology we call these SystemSpecification, SystemArchitecture and SystemIntegration.

We will add the required SysML v2 code in the Elan8 Domain Libraries https://github.com/elan8/sysml-domain-libraries

Discussion with ChatGPT:  

I think I want to change the Elan8 MBSE methodology to use the Black Box/ Grey Box/ white box approach as explained here. https://www.incose.org/wp-content/uploads/2026/10/A_SysML_V2_Modeling_Pattern_for_Recursive_System_Decompostion_Presentation.pdf what do you think? We can then add abstract part def SystemSpecification, SystemArchitecture and SystemIntegration to the domain libraries to support this methodology..
Yes—I think this is a strong direction for Elan8. I would adopt it as the methodology’s core pattern for recursive system design, while keeping your existing question-driven engineering increments.

Your current method explains how to develop and review useful model content. This pattern adds a clearer relationship between what a system promises, how it is designed, and which subsystem designs are integrated.

The presentation’s distinction maps well to your proposed names:

Pattern	Elan8 definition	Meaning
Black box	SystemSpecification	Observable behavior, external interfaces, properties and constraints
Grey box	SystemArchitecture	Design choices, connections and constituent parts typed by subsystem specifications
White box	SystemIntegration	Integrated design that refines those parts with selected subsystem designs
That recursive separation is the main strength of the presentation. A subsystem can be developed against its specification while its parent architecture remains stable. 

The three abstract definitions make sense, but they need a modeling pattern alongside them. Inheriting from SystemArchitecture identifies a model’s role; it does not establish which particular specification the architecture conforms to.

For example, the intended specialization relationships would be:

abstract part def SystemSpecification;
abstract part def SystemArchitecture :> SystemSpecification;
abstract part def SystemIntegration :> SystemArchitecture;

part def DriveSpecification :> SystemSpecification;
part def DriveArchitecture
    :> DriveSpecification, SystemArchitecture;

part def MachineSpecification :> SystemSpecification;

part def MachineArchitecture
    :> MachineSpecification, SystemArchitecture {
    part drive : DriveSpecification;
}

part def MachineIntegration
    :> MachineArchitecture, SystemIntegration {
    part redefines drive : DriveArchitecture;
}
This is an illustrative skeleton, rather than a validated library implementation. Notice the two distinct relationships: MachineArchitecture has the methodology role and specializes its actual contract, MachineSpecification.

I would make five choices explicit in the methodology:

Apply the pattern at useful boundaries. Avoid requiring three definitions for every small component.
Keep box color separate from logical/physical abstraction. Both logical and physical designs can have specifications, architectures and integrated configurations.
Retain explicit requirements and verification. Specialization carries model constraints; it does not establish that a delivered system meets its requirements.
Treat integration as a selected design configuration. SystemIntegration should mean an integrated system representation; integration activities and test cases remain separate.
Check contextual refinements carefully. A parent’s tighter constraint on a subsystem usage does not automatically update the independently defined subsystem design. The presentation explicitly highlights this reconciliation problem. 
For the domain libraries, I would put these definitions in a small, domain-independent package such as Elan8::SystemsEngineering. Photonics, mechatronics and other domain libraries could then build on it. Your current README says the method requires no custom library; I would preserve that accessibility by making this a supported library binding, with the underlying pattern usable through native SysML v2 alone.

The tooling opportunity is valuable too: Spec42 could recognize these roles and check for internal decomposition in specifications, missing contract specialization, and incompatible subsystem refinements. Those checks would make the definitions useful beyond naming.

My recommendation is to adopt the pattern and prove it through the existing elevator example first. Model the elevator-system contract, an architecture containing car/controller specifications, and an integrated configuration selecting their designs. That will expose the practical issues before restructuring the whole methodology.

Ok, I guess the MBSE process would then be : define context, define use cases, define customer/ user requirements, define system requirements and then start the recursive decomposition as just discussed?
Yes—that is a good overall flow. I would make one adjustment: system specification and recursive decomposition belong together, because every subsystem gets its own specification before its design is developed.

The process could be:

Step	Main question	Main content
1. Define context	Why is the system needed, and where is its boundary?	Stakeholders, objectives, environment, external systems and constraints
2. Explore use cases	How will the system be used?	Operational scenarios, interactions, exceptional situations and lifecycle scenarios
3. Capture stakeholder requirements	What outcomes and obligations must be met?	Customer/user needs, supplied requirements and acceptance expectations
4. Define the system specification	What must the system do at its boundary?	System requirements, externally observable behavior, interfaces, properties and constraints
5. Develop the architecture recursively	How will the system fulfill its specification?	Design choices, subsystem specifications, responsibilities, connections and budgets
6. Integrate selected designs	Do the subsystem designs fit together and fulfill the system contract?	Integrated configuration, analyses and verification evidence
Step 4 creates the top-level black box. System requirements are part of that contract, but requirements alone are insufficient: typed interfaces, behavior and measurable properties make the specification much more precise.

Within step 5, the recurring engineering cycle is:

Define or refine the system’s specification.
Explore and select an architecture that fulfills it.
Define the specifications of its constituent subsystems, deriving requirements and allocating responsibilities and budgets.
Develop those subsystems through the same cycle.
Integrate their selected designs into the parent and evaluate the result.
For example, a machine-level throughput requirement might lead to a particular architecture, which then produces timing obligations for transport, processing and control subsystems. Those subsystem requirements emerge from the architectural decisions.

I would also make verification planning start with the specification: when defining an obligation, establish how you intend to assess it. Analysis and verification then accompany architecture and integration.

Finally, describe this as a default reasoning order with feedback loops, rather than mandatory sequential phases. Existing hardware, feasibility findings or a difficult use case can force an earlier specification to change. That fits your current principle: start with an engineering question and develop only the connected model needed to answer it.

And how should we structure it? Package per subsystem that contains requirements, blackbox and Grey Box for that system?
Yes—a package per system or subsystem is a good default. Each package owns its contract, architecture and integration, and applies the same structure recursively.

I would start with:

Machine
├── Context
├── UseCases
├── StakeholderRequirements
├── Specification
│   ├── SystemRequirements
│   └── MachineSpecification          «black box»
├── Architecture
│   ├── MachineArchitecture           «grey box»
│   └── DesignDecisions
├── Subsystems
│   ├── Transport
│   │   ├── Specification
│   │   ├── Architecture
│   │   ├── Subsystems
│   │   ├── Integration
│   │   └── Verification
│   └── Processing
│       └── …
├── Integration
│   └── MachineIntegration            «white box»
└── Verification
The labels in guillemets describe roles here; they are not proposed SysML stereotypes.

The package tree organizes engineering ownership; the part usages define the system composition. MachineArchitecture would contain a transport part typed by TransportSpecification. MachineIntegration would redefine that usage with the selected transport design. Placing Transport inside a package does not itself establish either relationship.

A few conventions would keep this manageable:

Content	Ownership rule
System requirements	Owned by the system whose boundary they constrain
Subsystem requirements	Owned by that subsystem; linked to parent obligations through derivation where appropriate
Interface definitions	Owned by the responsible contract owner or a shared interface package; referenced by participants
Verification cases	Owned at the level of the obligation they assess
Reusable subsystem designs	Defined outside a particular machine package and referenced by its architecture
I would keep requirements inside Specification, alongside the black-box definition. They express one contract through complementary constructs. The black-box definition can reference or expose applicable requirements without duplicating their definitions.

Also, avoid requiring Context, UseCases and StakeholderRequirements folders at every level. At subsystem level, the parent architecture often supplies most of that context. Add local scenarios and stakeholder content when they clarify something.

For a small subsystem, this can simply be one package containing:

Transport
├── Requirements
├── TransportSpecification
├── TransportArchitecture
├── TransportIntegration
└── Verification
Use the same conceptual structure everywhere, but introduce subpackages only when the amount of content warrants them. This would shift Elan8 from global folders for all requirements, functions and physical parts toward system-owned packages, with views providing the cross-system overviews.
