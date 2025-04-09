# TLA+ Specification Template for Vibe Coding

This repository provides a template for writing TLA+ specifications and verifying them using the TLC model checker within a Docker environment. It's designed to be used as a starting point for formal specification within Vibe Coding projects.

## Prerequisites

- Docker
- Docker Compose

## Directory Structure

- `compose.yaml`: Defines the Docker Compose service for running TLA+ tools.
- `Dockerfile`: Defines the Docker image with Java and TLA+ tools installed.
- `exec.sh`: A helper script to translate (PlusCal) and run the TLC model checker on a specification.
- `specs/`: Contains the TLA+ specification files.
  - `SimpleSpec/`: An example specification directory.
    - `Spec.tla`: The main TLA+ specification file for the simple example.
    - `Spec.cfg`: Configuration file for the TLC model checker (optional).

## Usage

1. **Write your TLA+ specification:** Create a new directory under `specs/` (e.g., `specs/MyNewSpec/`) and place your `.tla` file (e.g., `specs/MyNewSpec/MySpec.tla`) inside it. You can also include a `.cfg` file for TLC configuration if needed.
2. **Translate and Model Check:** Use the `exec.sh` script, providing the path to your `.tla` file as an argument.

    ```bash
    ./exec.sh specs/YourSpecDir/YourSpec.tla
    ```

    This command will:
    - Start the Docker container defined in `compose.yaml`.
    - Run `pcal.trans` to translate any PlusCal code within your `.tla` file.
    - Insert properties.tla to Spec.tla
    - Run `tlc2.TLC` to model check your specification.

## Example: Running SimpleSpec

To run the included `SimpleSpec` example:

```bash
./exec.sh specs/SimpleSpec/Spec.tla
```

The script will execute the translation and model checking steps for `specs/SimpleSpec/Spec.tla`. Check the output for results from the TLC model checker.

Result is following.

```
Error: Deadlock reached.
Error: The behavior up to this point is:
State 1: <Initial predicate>
/\ flag = <<FALSE, FALSE>>
/\ pc = <<"ncs", "ncs">>
/\ trying = <<FALSE, FALSE>>

State 2: <ncs line 46, col 14 to line 49, col 28 of module Spec>
/\ flag = <<FALSE, FALSE>>
/\ pc = <<"enter", "ncs">>
/\ trying = <<TRUE, FALSE>>

State 3: <enter line 51, col 16 to line 54, col 34 of module Spec>
/\ flag = <<TRUE, FALSE>>
/\ pc = <<"wait", "ncs">>
/\ trying = <<TRUE, FALSE>>

State 4: <ncs line 46, col 14 to line 49, col 28 of module Spec>
/\ flag = <<TRUE, FALSE>>
/\ pc = <<"wait", "enter">>
/\ trying = <<TRUE, TRUE>>

State 5: <enter line 51, col 16 to line 54, col 34 of module Spec>
/\ flag = <<TRUE, TRUE>>
/\ pc = <<"wait", "wait">>
/\ trying = <<TRUE, TRUE>>
```
