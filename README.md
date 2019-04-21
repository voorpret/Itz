Me he guiado por el patrón MVC, intentado no cargar de funcionalidades al controlador. No he
utilizado ningún pod, soy partidario de considerarlos el último recurso. 

Creo que es buena practica que las propiedades de los modelos no sean opcionales, 
ya que ahorra bastante casuística, pero en este caso el modelo News tienes las propiedades
como opcionales ya que vienen como null en el servicio de forma aleatoria, no es consistente. 
