<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        // Eliminar la tabla si ya existe
        Schema::dropIfExists('reports');

        Schema::create('reports', function (Blueprint $table) {
            // Para especificar que el dato es una llave primaria se usa el "primary()"
            $table->string('folio', 10)->primary(); 
            $table->string('buildingID', 1); // El numero "10" es especificar el tamaño del campo (pueden ser mas, según sea el caso)
            $table->string('roomID', 10);
            $table->unsignedBigInteger('categoryID'); 
            $table->unsignedBigInteger('goodID');
            $table->enum('priority', ['Immediate', 'Normal']); // Entre corchetes se especifican los valores permitidos
            $table->text('description');
            $table->string('image')->nullable(); 
            $table->unsignedBigInteger('userID');
            $table->enum('status', ['Pending', 'In Progress', 'Completed'])->default('Pending'); 
            $table->timestamps(); // Este dato siempre se coloca y es para especificar la fecha de creación y modificación


            // De esta manera se puede definir cuales datos son unas llaves foraneas
            $table->foreign('buildingID')->references('buildingID')->on('buildings')->onDelete('cascade');
                //Con "foreign" se especifica que es una llave foranea, y se coloca como aparece en esta tabla(reports)

            $table->foreign('roomID')->references('roomID')->on('rooms')->onDelete('cascade');
                                //Con "references" se especifica la llave foranea que queremos agarrar y se coloca como se encuntra originalmente en su tabla

            $table->foreign('categoryID')->references('categoryID')->on('categories')->onDelete('cascade');
                                                                //Con "on" se especifica la tabla en donde se encuentra la llave foranea

            $table->foreign('userID')->references('user_id')->on('users')->onDelete('cascade');
                                                                        //El "onDelete" es para especificar que se hara con los datos relacionados y se coloca por defecto

            $table->foreign('goodID')->references('goodID')->on('goods')->onDelete('cascade');
        });
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
