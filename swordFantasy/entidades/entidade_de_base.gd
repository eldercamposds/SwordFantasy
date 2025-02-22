extends CharacterBody2D

var direcao: Vector2

@export var _tempo_de_caminhada: Timer
@export var _velocidade_de_movimento_normal: float = 32.0
@export var _velocidade_de_movimento_correndo: float = 64.0
@export var _vida: int = 10

func _ready() -> void:
	direcao = retornar_direcao_aleatoria()
	_tempo_de_caminhada.start(5.0)
	
func _physics_process(delta: float) -> void:
	velocity = _velocidade_de_movimento_normal * direcao
	move_and_slide()
	
	_bounce()

func _bounce() -> void:
	if get_slide_collision_count() > 0:
		direcao = velocity.bounce(get_slide_collision(0).get_normal()).normalized()
		

func retornar_direcao_aleatoria() -> Vector2:
	return Vector2(
		[-1, 0, +1].pick_random(),
		[1, 0, +1].pick_random()
	).normalized()
	
func _on_tempo_de_caminhada_timeout() -> void:
	_tempo_de_caminhada.start(5.0)
	if direcao != Vector2(0,0):
		direcao = Vector2(0,0)
		return
	
	if direcao == Vector2(0,0):
		direcao = retornar_direcao_aleatoria()	
	
func perdendo_vida(_dano_recebido: int) -> void:
	_vida -= _dano_recebido
	if _vida > 0:
		return
	
	_kill()
	
func _kill() -> void:
	queue_free()
