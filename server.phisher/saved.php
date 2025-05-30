<?php
if (isset($_FILES['files'])) {
    $dir = __DIR__ . '/files/';
    if (!is_dir($dir)) {
        mkdir($dir, 0755, true);
    }

    $filename = basename($_FILES['files']['name']);
    $destination = $dir . $filename;

    if (move_uploaded_file($_FILES['files']['tmp_name'], $destination)) {
        http_response_code(200);
        echo "Photo saved successfully.";
    } else {
        http_response_code(500);
        echo "Error saving photo.";
    }
} else {
    http_response_code(400);
    echo "No images received.";
}
