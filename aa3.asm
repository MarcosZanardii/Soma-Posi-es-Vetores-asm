.text
    .globl  inicio
    
inicio:
    la $s0, A            # carrega endereço de A
    la $s1, B            # carrega endereço de B
    la $s2, C            # carrega endereço de C
    la $s3, D            # carrega endereço de D
    la $s4, somaC        # carrega endereço de somaC
    la $s5, somaD        # carrega endereço de somaD
    la $s6, maior        # carrega endereço de maior
    la $s7, soma         # carrega endereço de soma
    move $t8, $zero      # t9 -> i = 0

loop:  
    lw $t0, 0($s0)       # carrega A[i] em $t0
    lw $t1, 0($s1)       # carrega B[i] em $t1
    
    add $t2, $t0, $t1    # C[i]($t2) = A[i] + B[i]
    add $t4, $t4, $t2    # t4 += C[i]
    
    sub $t3, $t0, $t1    # D[i]($t3) = A[i] - B[i]
    add $t5, $t5, $t3    # t5 += D[i]

    bgt $t2, $t3, maiorC            # se C[i] > D[i], vai para maiorC
    bgt $t3, $t6, atualiza_maior    # se D[i] > maior, atualiza maior
    
    j incrementa          # se nenhum dos casos, vai para incrementa

maiorC:
    bgt $t2, $t6, atualiza_maior_t2    # se C[i] > maior, vai para atualiza_maior_t2
    j incrementa
    
atualiza_maior:
    move $t6, $t3       # atualiza maior com $t3(D[i])
    j incrementa

atualiza_maior_t2:
    move $t6, $t2       # atualiza maior com $t2(C[i])
    j incrementa
    
write_mem:
    sw $t2, 0($s2)      # salva (A[i] + B[i]) em C[i]
    sw $t3, 0($s3)      # salva (A[i] - B[i]) em D[i]
    sw $t4, 0($s4)      # salva atual valor de somaC
    sw $t5, 0($s5)      # salva atual valor de somaD
    sw $t6, 0($s6)      # salva atual maior valor

    jr $ra
    
incrementa:        

    jal write_mem
    
    addi $s0, $s0, 4    # incrementa posicao de A[]
    addi $s1, $s1, 4    # incrementa posicao de B[]
    addi $s2, $s2, 4    # incrementa posicao de C[]
    addi $s3, $s3, 4    # incrementa posicao de D[]
    addi $t8, $t8, 1    # i++
  
    blt $t8, 8, loop    # se i < 8, entao vai para loop
    
sub_rotina:             # SM = maior * (somaC + somaD)

    lw $s4, 0($s4)      # carrega valor de somaC
    lw $s5, 0($s5)      # carrega valor de somaD
    lw $s6, 0($s6)      # carrega valor de maior
    
    add $s0, $s4, $s5   # s0 = somaC + somaD
    move $t9, $zero     # i = 0
    
multi:
    
    addi $t9, $t9, 1    # i++
    add $t7, $t7, $s0   # SM  += (somaC + somaD) 
    blt $t9, $s6, multi # adiciona "soma" a si mesmo, "maior" vezes   
 	
 	#salvar em t7 o que tem em t7
    sw $t7, 0($s7)
fim:    j fim 

.data

A:      .word 15 12 -17 25 -30 -18 22 11
B:      .word 20 -14 19 -16 -28 13 -10 27
C:      .word 0 0 0 0 0 0 0 0
D:      .word 0 0 0 0 0 0 0 0
somaC:  .word 0
somaD:  .word 0
maior:  .word 0
soma:   .word 0
