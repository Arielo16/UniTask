<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up()
    {
        // Eliminar la tabla si ya existe
        Schema::dropIfExists('reports');

        Schema::create('reports', function (Blueprint $table) {
            // Para especificar que el dato es una llave primaria se usa el "primary()"
            $table->string('folio', 10)->primary(); 
            $table->string('buildingID', 10); // Asegúrate de que el tamaño sea 10
            $table->string('roomID', 10);
            $table->unsignedBigInteger('categoryID'); 
            $table->unsignedBigInteger('goodID');
            $table->enum('priority', ['Immediate', 'Normal']); // Entre corchetes se especifican los valores permitidos
            $table->text('description');
            $table->string('image')->nullable(); 
            $table->string('matricula', 20); // Asegúrate de que el tamaño sea 20
            $table->enum('status', ['Pending', 'In Progress', 'Completed'])->default('Pending'); 
            $table->timestamps(); // Este dato siempre se coloca y es para especificar la fecha de creación y modificación


            // De esta manera se puede definir cuales datos son unas llaves foraneas
            $table->foreign('buildingID')->references('buildingID')->on('buildings')->onDelete('cascade');
                //Con "foreign" se especifica que es una llave foranea, y se coloca como aparece en esta tabla(reports)

            $table->foreign('roomID')->references('roomID')->on('rooms')->onDelete('cascade');
                                //Con "references" se especifica la llave foranea que queremos agarrar y se coloca como se encuntra originalmente en su tabla

            $table->foreign('categoryID')->references('categoryID')->on('categories')->onDelete('cascade');
                                                                //Con "on" se especifica la tabla en donde se encuentra la llave foranea

            $table->foreign('matricula')->references('matricula')->on('users')->onDelete('cascade');
                                                                        //El "onDelete" es para especificar que se hara con los datos relacionados y se coloca por defecto

            $table->foreign('goodID')->references('goodID')->on('goods')->onDelete('cascade');
        });

        DB::table('reports')->insert([
            [
                'folio' => 'REPZH17CUT',
                'buildingID' => 'A',
                'roomID' => 'A101',
                'categoryID' => 1,
                'goodID' => 1,
                'priority' => 'Normal',
                'description' => 'Silla rota en el aula A101',
                'image' => 'silla_rota.jpg',
                'matricula' => '23090565',
                'status' => 'Pending',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REPZH18CUT',
                'buildingID' => 'B',
                'roomID' => 'B202',
                'categoryID' => 3,
                'goodID' => 11,
                'priority' => 'Immediate',
                'description' => 'Cambio de bombillo en el aula B202',
                'image' => 'bombillo.jpg',
                'matricula' => '23090566',
                'status' => 'In Progress',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REPZH19CUT',
                'buildingID' => 'C',
                'roomID' => 'C303',
                'categoryID' => 2,
                'goodID' => 6,
                'priority' => 'Normal',
                'description' => 'Ventana rota en el aula C303',
                'image' => 'ventana_rota.jpg',
                'matricula' => '23090565',
                'status' => 'Pending',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REPZH20CUT',
                'buildingID' => 'E',
                'roomID' => 'E404',
                'categoryID' => 5,
                'goodID' => 21,
                'priority' => 'Immediate',
                'description' => 'Fuga de agua en el laboratorio E404',
                'image' => 'fuga_agua.jpg',
                'matricula' => '23090566',
                'status' => 'Completed',
                'created_at' => now(),
                'updated_at' => now()
            ],
            [
                'folio' => 'REPZH21CUT',
                'buildingID' => 'F',
                'roomID' => 'F505',
                'categoryID' => 7,
                'goodID' => 31,
                'priority' => 'Normal',
                'description' => 'Aire acondicionado no funciona en el aula F505',
                'image' => 'aire_acondicionado.jpg',
                'matricula' => '23090565',
                'status' => 'Pending',
                'created_at' => now(),
                'updated_at' => now()
            ],
            // Agrega más datos según sea necesario
        ]);
    }

    /**
     * Reverse the migrations. 
     * 
     * @return void
     */
    // Este metodo se utiliza para eliminar la tabla y se coloca por defecto
    public function down()
    {
        Schema::dropIfExists('reports');
    }
};
