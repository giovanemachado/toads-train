extends Resource

class_name PlayerProgress

@export_group("Player Info")
@export var max_distance_reach: int = 0
@export var money: int = 0

@export_group("Player Upgrades")
@export var damage: int = 1
@export var speed: int = 1
@export var hp: int = 1

@export_group("Train Upgrades")
@export var train_fuel: int = 30
@export var train_resist: int = 10
@export var train_speed: int = 10
