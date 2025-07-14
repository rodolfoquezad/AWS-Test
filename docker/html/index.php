<html>
    <head>
        <meta charset="utf-">
        <title>AWS-Test</title>
    </head>
    <body>
        <h1>Hola Mundo!</h1>
    </body>
</html>

 <?php
    $db_host = getenv('DB_HOST');
    $db_user = getenv('DB_USER'); 
    $db_pass = getenv('DB_PASS'); 
    $db_name = 'postgres';        

    try {
        $conn = new PDO("pgsql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
        
        $conn->exec("CREATE TABLE IF NOT EXISTS registros_visitas (
            id SERIAL PRIMARY KEY,
            fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            ip VARCHAR(45),
            user_agent VARCHAR(255)
        )");

        $ip = $_SERVER['REMOTE_ADDR'];
        $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? 'Desconocido';
        
        $stmt = $conn->prepare("INSERT INTO registros_visitas (ip, user_agent) VALUES (?, ?)");
        $stmt->execute([$ip, $user_agent]);

        echo "✅ Visita registrada a las " . date('H:i:s');

    } catch(PDOException $e) {
        echo "⚠️ Error: La visita no pudo registrarse";
    }
    ?>
