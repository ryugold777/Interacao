extends Area2D
# Declaração das variáveis
var pagina = 0
var totalPaginas = 2
var proximoTexto
var objeto
var proximaPagina = true
var finalizarTexto
                     #página 0               página 1              p
var mensagem = ["oi tudo bom com voce", "ola ok voce esta aqui", "bom ainda bem"]
# Inicia não mostrando a imagem da caixa de mensagem
func _ready():
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible = false

# Função mostrar a mensagem
func mostrarMensagem():
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.bbcode_enabled = true
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.set_bbcode(mensagem[pagina])
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.show()

# Função esconder a mensagem
func esconderMensagem():
	$Imagem_Caixa_Mensagem.visible = false
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.hide()
	$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters = 0

# Função interagir com objetos e NPC's
func interacao():
	if Input.is_action_just_pressed("confirmar") && proximaPagina == true:
			$Imagem_Caixa_Mensagem.visible = true
			pagina = 0
			while $Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters < $Imagem_Caixa_Mensagem/Exibir_Mensagem.text.length():
				$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters += 1
				yield(get_tree().create_timer(0.1), "timeout")
				mostrarMensagem()

			finalizarTexto = true
			proximaPagina = false


# Próxima página. Para mais páginas acrescentar no topo do script
	if Input.is_action_just_released("confirmar") && finalizarTexto == true:
		if pagina < totalPaginas && $Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters >= $Imagem_Caixa_Mensagem/Exibir_Mensagem.text.length():
			pagina = pagina + 1
			$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters = -1
			while $Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters < $Imagem_Caixa_Mensagem/Exibir_Mensagem.text.length():
				$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters += 1
				yield(get_tree().create_timer(0.1), "timeout")
				mostrarMensagem()
		if pagina >= 1:
				mostrarMensagem()
		if pagina >= totalPaginas && $Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters >= $Imagem_Caixa_Mensagem/Exibir_Mensagem.text.length():
			proximoTexto = true
#Fim da mensagem
	if Input.is_action_just_released("confirmar") && proximoTexto == true:
		esconderMensagem()
		proximoTexto = false
		yield(get_tree().create_timer(0.3), "timeout")
		$Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters =  0
		proximaPagina = true
		finalizarTexto = false

# Chamada da função interacao()
func _process(_delta):
	interacao()
#	print($Imagem_Caixa_Mensagem/Exibir_Mensagem.get_total_character_count())
#	print(mensagem[pagina].length())
#	print($Imagem_Caixa_Mensagem/Exibir_Mensagem.visible_characters)
	print(pagina)
# Quando entrar na área
func entrar_area(body):	
	if (body.get_name() == "Robin_Erikson"):
		objeto = true

# Quando sair da área
func sairArea(_body):
	objeto = false
