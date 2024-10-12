# Sequential Multiplier

## Hierarchy
```
├── Seq_Mult_Display.v
    ├── Seq_Mult.v
    │   ├── Controller.v
    │   └── Data_Path.v
    │       └── D_Latch_Reg.v
    └── Display.v
        ├── Clock_Enable.v
        ├── Anode_Driver.v
        └── Hex_To_Sev_Seg.v
```

![image](https://github.com/JermYeWorm/Sequential-Multiplier/assets/113321384/59183853-210f-4650-b086-951eaff33a4d)
<br>_Fig 1. 4-bit Sequential Multiplier Data Path_<br><br>

![image](https://github.com/JermYeWorm/sequential-multiplier/assets/113321384/9c5d4735-c65b-46c3-9520-70bf315c7095)
<br>_Fig 2. 4-bit Sequential Multiplier Controller Finite State Machine_<br><br>

![image](https://github.com/JermYeWorm/sequential-multiplier/assets/113321384/83f19c54-91b3-4491-840d-2d89d29210fd)
<br>_Fig 3. Elaborated Design Schematic - System Level_<br><br>

![image](https://github.com/JermYeWorm/sequential-multiplier/assets/113321384/3941b575-d85e-4b54-bffd-f206aa60fff8)
<br>_Fig 3. Elaborated Design Schematic - Data Path Level_<br><br>

## Verification
![image](https://github.com/user-attachments/assets/afacd17c-c36a-4d30-a7fa-6cd24b9430eb)
<br>_Fig 4. Testbench Simulation_<br><br>

## Implementation
The multiplier was implemented on a Basys 3 Artix-7 FPGA board. The multiplier and multiplicand are the two digits on the left while the resulting product is shown on the right in hexadecimal. The multiplier and multiplicand are controlled by two sets of 4 switches on the far bottom right of the board.
<br>
![image](https://github.com/user-attachments/assets/e697aecc-9cc7-43f9-8366-23ef78bd1c67)
![image](https://github.com/user-attachments/assets/55aee893-9d67-4196-8bf8-e2bbd1b657ee)
![image](https://github.com/user-attachments/assets/b42442ed-a6a9-4ba7-8761-893c27e7b61c)
![image](https://github.com/user-attachments/assets/6e019a42-ae68-4188-911e-b41cf847faff)

# Delay
The worst case delay was measured on a DLA (Digital Logic Analyzer) and shown below to be 192 nanoseconds.
<br>
![image](https://github.com/user-attachments/assets/5224db4e-ea7f-4bd2-b48f-ee679d2c2b81)


