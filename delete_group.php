<?php
  require_once('includes/load.php');
  
   page_require_level(1);
?>
<?php
  $delete_id = delete_by_id('user_groups',(int)$_GET['id']);
  if($delete_id){
      $session->msg("s","Grupo eliminado");
      redirect('group.php');
  } else {
      $session->msg("d","Eliminación falló");
      redirect('group.php');
  }
?>
