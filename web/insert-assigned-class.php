 <?php  
 //insert.php  
 if(isset($_POST["classes_id"], $_POST["teacher_id"]))  
 {  
    $connect = mysqli_connect("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement", "root", "") or die("Connection Failed!");
    #classes_id is an attrbute of teachers table, which is the id attribute of the classes table
    $query = "INSERT INTO teachers(classes_id) VALUES ('".$_POST["classes_id"]."') where id=".$_POST["classes_id"]."";  
    $result = mysqli_query($connect, $query);  
    echo 'Classes Assigned!';  
 }  
 ?>
