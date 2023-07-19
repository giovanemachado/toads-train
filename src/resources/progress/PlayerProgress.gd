extends Resource

class_name PlayerProgress

@export_group("Player Info")
@export var max_distance_reach: int = 0
@export var money: int = 0

@export_group("Player Upgrades")
@export var damage: int = 1
@export var damage_level: int = 0
@export var speed: int = 300
@export var speed_level: int = 0
@export var hp: int = 15
@export var hp_level: int = 0

@export_group("Train Upgrades")
@export var train_fuel: int = 100
@export var train_fuel_level: int = 0
@export var train_resist: int = 10
@export var train_resist_level: int = 0
@export var train_speed: int = 100
@export var train_speed_level: int = 0
