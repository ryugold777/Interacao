extends Area2D

###############################################################################
# Script de mensagem. Adicionei raycast2D por que encontrei um pequeno bug.   #
# a variável "parar_player" serve para deixar o jogador parado quando         #
# interagir com alguma coisa.                                                 #
#                                                                             #
# Autor: Gold Angel                                                           #
# Data: Dias 13/27 de Dezembro de 2022, 16:56                                 #
###############################################################################

# Declaração das variáveis
var pagina = 0
var total_paginas = 0
var proxima_pagina
var colisao_player = false
var primeira_pagina = true
var finalizar_texto
var mensagem = ["Hello! How are you?"]
onready var texto_mensagem = get_parent().get_node("Imagem_Caixa_Mensagem_NPC/Caixa_Mensagem/Mensagem")
onready var exibir_caixa_mensagem = get_parent().get_node("Imagem_Caixa_Mensagem_Heba/Caixa_Mensagem")
onready var nome_npc = get_parent().get_node("Imagem_Caixa_Mensagem_NPC/Caixa_Mensagem/Nome_NPC")
onready var face_nome = get_parent().get_node("Imagem_Caixa_Mensagem_NPC/Facesets/Face_Nome")
onready var mina = get_parent().get_node("Player")
onready var interacao_nome_kinematicbody2D = get_parent().get_node("RayCast2D")

# Função mostrar a mensagem
func mostrarMensagem():
	exibir_caixa_mensagem.visible = true
	texto_mensagem.bbcode_enabled = true
	face_npc.visible = true
	texto_mensagem.set_bbcode(mensagem[pagina])
	texto_mensagem.show()
	nome_recepcionista.text = "Nome NPC"

# Função esconder a mensagem
func esconder_mensagem():
	exibir_caixa_mensagem.visible = false
	face_npc.visible = false
	texto_mensagem.hide()
	texto_mensagem.visible_characters = 0

# Função interagir com objetos e NPC's
func interacao():
	if Input.is_action_just_pressed("atirar") && (primeira_pagina == true) && interacao_recepcionista_npc.is_colliding() && (player.animation == "Direita"):
			get_parent().get_node("Player").parar_player = true
			exibir_caixa_mensagem.visible = true
			pagina = 0
			$som_texto.stream_paused = false
			while (texto_mensagem.visible_characters) <= (texto_mensagem.text.length()):
				texto_mensagem.visible_characters += 1
				$som_texto.play()
				yield(get_tree().create_timer(0.1), "timeout")
				mostrarMensagem()

			finalizar_texto = true
			primeira_pagina = false

# Próxima página. Para mais páginas acrescentar no topo do script
	if Input.is_action_just_released("confirmar") && proxima_pagina == true:
		if (pagina < total_paginas) && (texto_mensagem.visible_characters) >= (texto_mensagem.text.length()):
			texto_mensagem.visible_characters = -1
			pagina = pagina + 1
			while (texto_mensagem.visible_characters) < (texto_mensagem.text.length()):
				texto_mensagem.visible_characters += 1
				yield(get_tree().create_timer(0.1), "timeout")
				mostrarMensagem()
		if (pagina > 1):
				mostrarMensagem()
		if (pagina >= total_paginas) && (texto_mensagem.visible_characters) >= (texto_mensagem.text.length()):
			finalizar_texto = true

#Fim da mensagem
	if (Input.is_action_just_released("atirar")) && (finalizar_texto == true) && (player.animation == "Direita"):
		get_parent().get_node("Player").parar_mina = false
		$som_texto.stream_paused = true
		esconder_mensagem()
		$som_texto.stop()
		proxima_pagina = false
		yield(get_tree().create_timer(0.3), "timeout")
		texto_mensagem.visible_characters =  0
		finalizar_texto = false
		permissao_entrar_porta_presidente = true
		primeira_pagina = true

func _physics_process(_delta):
	interacao()
