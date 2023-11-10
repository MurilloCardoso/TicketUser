
package com.example.app;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;
import android.os.Bundle;
import android.content.Intent;
import android.provider.MediaStore;
import android.net.Uri;
import android.os.Bundle;
import android.widget.ImageView;
import android.content.ContentResolver;
import android.database.Cursor;
import android.provider.MediaStore;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/gallery";

    private static final int PICK_IMAGE_REQUEST = 1;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                        if (call.method.equals("openGallery")) {
                             openGallery();
                        
                        } else {
                            result.notImplemented();
                        }
                    }
                }
            );
    }
    private void openGallery() {
        Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
        startActivityForResult(intent, PICK_IMAGE_REQUEST);
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == PICK_IMAGE_REQUEST && resultCode == RESULT_OK && data != null) {
            Uri selectedImageUri = data.getData();

         String filePath=getRealPathFromUri(selectedImageUri);
            new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL)
                .invokeMethod("imageSelected",filePath);
        }
    }

    private String getRealPathFromUri (Uri uri){
        String filePath="";

        if (getContentResolver() != null) {
            Cursor cursor = getContentResolver().query(uri, null, null, null, null);
            if (cursor != null) {
                cursor.moveToFirst();
                int columnIndex = cursor.getColumnIndex(MediaStore.Images.Media.DATA);
                filePath = cursor.getString(columnIndex);
                cursor.close();
            }
        }
        return filePath;

    }

    // public void configureFlutterEngine(FlutterEngine flutterEngine) {
    //     super.configureFlutterEngine(flutterEngine);

    //     new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
    //             .setMethodCallHandler((call, result) -> {
    //                 if (call.method.equals("getFirstPage")) {
    //                     String pdfPath = "caminho_para_seu_pdf.pdf";
    //                     String imagePath = getFirstPageImage(pdfPath);
    //                     result.success(imagePath);
    //                 } else {
    //                     result.notImplemented();
    //                 }
    //             });
    // }
    // private String getFirstPageImage(String pdfPath) {
    //     String imagePath = "";
    //     try {
    //         ParcelFileDescriptor fileDescriptor = ParcelFileDescriptor.open(new File(pdfPath), ParcelFileDescriptor.MODE_READ_ONLY);
    //         PdfRenderer pdfRenderer = new PdfRenderer(fileDescriptor);
    //         PdfRenderer.Page page = pdfRenderer.openPage(0);

    //         Bitmap bitmap = Bitmap.createBitmap(page.getWidth(), page.getHeight(), Bitmap.Config.ARGB_8888);
    //         page.render(bitmap, null, null, PdfRenderer.Page.RENDER_MODE_FOR_DISPLAY);

    //         File imageFile = new File(getFilesDir(), "first_page_image.jpg");
    //         FileOutputStream outputStream = new FileOutputStream(imageFile);
    //         bitmap.compress(Bitmap.CompressFormat.JPEG, 85, outputStream);
    //         outputStream.close();

    //         imagePath = imageFile.getAbsolutePath();

    //         page.close();
    //         pdfRenderer.close();
    //         fileDescriptor.close();
    //     } catch (IOException e) {
    //         e.printStackTrace();
    //     }

    //     return imagePath;
    // }
}