extends Area2D

###############################################################################
# Script para interagir com NPC's e objetos. Caso o personagem "Robin_Erikson"#
# Entra na área e presione a tecla de confirmar abrirá uma caixa de           #
# mensagem. O valor da variável "pagina" dever ser sempre zero. O que deve    #
# mudar é a variável "total_paginas". Caso o personagem saia da área e        #
# pressionar a tecla de confirmação, não acontecerá nada. O Nó/Node           #
# "$Imagem_Caixa_Mensagem/Exibir_Mensagem" é RichTextLabel.                   #
#                                                                             #
#                                                                             #
# Autor: Gold Angel                                                           #
# Data: Dias 5/25 de Dezembro de 2022, 18:45                                  #
# Agradecimentos/Thanks to a KoBeWi                                           #
###############################################################################

# Declaração das variáveis
var pagina = 0
var total_paginas = 2
var proximo_texto
var objeto
var proxima_pagina = true
var finalizarTexto
                     #página 0               página 1              p
var mensagem = ["oi tudo bom com voce", "ola ok voce esta aqui", "bom ainda bem"]
# Inicia não mostrando a imagem da caixa de mensagem
func _ready():
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible = false

# Função mostrar a mensagem
func mostrar_mensagem():
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.bbcode_enabled = true
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.set_bbcode(mensagem[pagina])
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.show()

# Função esconder a mensagem
func esconder_mensagem():
	$Imagem_Caixa_Mensagem.visible = false
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.hide()
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters = 0

# Função interagir com objetos e NPC's
func interacao():
	if Input.is_action_just_pressed("confirmar") && proxima_pagina == true:
			$Imagem_Caixa_Mensagem.visible = true
			pagina = 0
			while $Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters < $Imagem_Caixa_Mensagem/Exibir_Mensagem.text.length():
				$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters += 1
				yield(get_tree().create_timer(0.1), "timeout")
				mostrar_mensagem()

			finalizar_texto = true
			proxima_pagina = false


# Próxima página. Para mais páginas acrescentar no topo do script
	if Input.is_action_just_released("confirmar") && finalizar_texto == true:
		if pagina < totalPaginas && $Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters >= $Imagem_Caixa_Mensagem/Exibir_Mensagem.text.length():
			pagina = pagina + 1
			$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters = -1
			while $Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters < $Imagem_Caixa_Mensagem/Exibir_Mensagem.text.length():
				$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters += 1
				yield(get_tree().create_timer(0.1), "timeout")
				mostrar_mensagem()
		if pagina >= 1:
				mostrar_mensagem()
		if pagina >= totalPaginas && $Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters >= $Imagem_Caixa_Mensagem/Exibir_Mensagem.text.length():
			proximo_texto = true
#Fim da mensagem
	if Input.is_action_just_released("confirmar") && proximo_texto == true:
		esconder_mensagem()
		proximo_texto = false
		yield(get_tree().create_timer(0.3), "timeout")
		$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters =  0
		proxima_pagina = true
		finalizar_texto = false

# Chamada da função interacao()
func _process(_delta):
	interacao()

# Quando entrar na área
func entrar_area(body):	
	if (body.get_name() == "Robin_Erikson"):
		objeto = true

# Quando sair da área
func sairArea(_body):
	objeto = false
