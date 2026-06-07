
stateDiagram-v2

[*] --> start

start --> read_M : M
start --> read_D : D
start --> read_C : C
start --> read_L : L
start --> read_X : X
start --> read_V : V
start --> read_I : I

read_M --> read_MM : M
read_M --> start : D,C,L,X,V,I / M

read_MM --> read_MMM : M
read_MM --> start : D,C,L,X,V,I / MM

read_MMM --> start : D,C,L,X,V,I / MMM

read_D --> read_C_after_D : C
read_D --> start : L,X,V,I / D

read_C_after_D --> read_CC_after_D : C
read_C_after_D --> start : L,X,V,I / DC

read_CC_after_D --> read_CCC_after_D : C
read_CC_after_D --> start : L,X,V,I / DCC

read_CCC_after_D --> start : L,X,V,I / DCCC

read_C --> read_CC : C
read_C --> start : M / CM
read_C --> start : D / CD
read_C --> start : L,X,V,I / C

read_CC --> read_CCC : C
read_CC --> start : L,X,V,I / CC

read_CCC --> start : L,X,V,I / CCC

read_L --> read_X_after_L : X
read_L --> start : V,I / L

read_X_after_L --> read_XX_after_L : X
read_X_after_L --> start : V,I / LX

read_XX_after_L --> read_XXX_after_L : X
read_XX_after_L --> start : V,I / LXX

read_XXX_after_L --> start : V,I / LXXX

read_X --> read_XX : X
read_X --> start : C / XC
read_X --> start : L / XL
read_X --> start : V,I / X

read_XX --> read_XXX : X
read_XX --> start : V,I / XX

read_XXX --> start : V,I / XXX

read_V --> read_I_after_V : I
read_V --> start : C,L,X,M / V

read_I_after_V --> read_II_after_V : I
read_I_after_V --> start : C,L,X,M / VI

read_II_after_V --> read_III_after_V : I
read_II_after_V --> start : C,L,X,M / VII

read_III_after_V --> start : C,L,X,M / VIII

read_I --> read_II : I
read_I --> start : V / IV
read_I --> start : X / IX

read_II --> read_III : I

read_III --> start