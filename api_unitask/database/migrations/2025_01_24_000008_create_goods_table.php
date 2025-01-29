<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up()
    {
        Schema::create('goods', function (Blueprint $table) {
            $table->id('goodID');
            $table->string('name'); 
            $table->unsignedBigInteger('categoryID'); 
            $table->timestamps(); 

            // Definimos la llave foránea
            $table->foreign('categoryID')->references('categoryID')->on('categories')->onDelete('cascade');
        });

        // Insertar bienes u objetos relacionados con las categorías
        DB::table('goods')->insert([
            // Bienes para Carpintería
            ['name' => 'Sillas de aula', 'categoryID' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Escritorios de profesor', 'categoryID' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Mesas de trabajo', 'categoryID' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Estanterías', 'categoryID' => 1, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Archiveros', 'categoryID' => 1, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Aluminios
            ['name' => 'Ventanas de aluminio', 'categoryID' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Puertas de aluminio', 'categoryID' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Marcos de ventanas', 'categoryID' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Rejas de protección', 'categoryID' => 2, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Paneles de aluminio para techos', 'categoryID' => 2, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Electricidad
            ['name' => 'Cables eléctricos', 'categoryID' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Interruptores', 'categoryID' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Tomacorrientes', 'categoryID' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Bombillos de luz LED', 'categoryID' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Equipos de medición eléctrica', 'categoryID' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Generadores eléctricos', 'categoryID' => 3, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Proyectores multimedia', 'categoryID' => 3, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Cristales
            ['name' => 'Vidrios para ventanas', 'categoryID' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Espejos grandes para pasillos', 'categoryID' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Cristales de seguridad para puertas', 'categoryID' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Paneles de vidrio templado', 'categoryID' => 4, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Cristales para tableros de anuncios', 'categoryID' => 4, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Fontanería
            ['name' => 'Tuberías de PVC', 'categoryID' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Fregaderos para laboratorios', 'categoryID' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Grifos', 'categoryID' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Lavamanos', 'categoryID' => 5, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Inodoros', 'categoryID' => 5, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Pintura
            ['name' => 'Pintura para paredes interiores', 'categoryID' => 6, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Pintura para exteriores', 'categoryID' => 6, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Tintes para laboratorios', 'categoryID' => 6, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Brochas', 'categoryID' => 6, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Pinceles', 'categoryID' => 6, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Aire Acondicionado
            ['name' => 'Aire acondicionado para aulas', 'categoryID' => 7, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Equipos de ventilación', 'categoryID' => 7, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Termostatos', 'categoryID' => 7, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Plomería
            ['name' => 'Bombas de agua', 'categoryID' => 8, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Llaves de paso', 'categoryID' => 8, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Lavamanos de cerámica', 'categoryID' => 8, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Tuberías de cobre', 'categoryID' => 8, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Sistemas Eléctricos (Cableado, redes)
            ['name' => 'Cableado estructurado para redes de datos', 'categoryID' => 9, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Servidores para redes', 'categoryID' => 9, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Modems', 'categoryID' => 9, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Routers', 'categoryID' => 9, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Sistemas de protección contra incendios
            ['name' => 'Extintores', 'categoryID' => 10, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Alarmas de incendios', 'categoryID' => 10, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Detectores de humo', 'categoryID' => 10, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Kits de primeros auxilios', 'categoryID' => 10, 'created_at' => now(), 'updated_at' => now()],

            // Bienes para Albañilería
            ['name' => 'Ladrillos', 'categoryID' => 11, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Cemento', 'categoryID' => 11, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Mortero', 'categoryID' => 11, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Arena', 'categoryID' => 11, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }

    public function down()
    {
        Schema::dropIfExists('goods');
    }
};
