import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.concurrent.TimeUnit;

public class JavaLoadTests {

    public static void main(String[] args) {

        for (int i = 1; i <= 10; i++) {
            System.out.println("Тест " + i + ": Имитация вычислительной нагрузки");
            heavyComputation();
            System.out.println("Тест " + i + " завершен\n");
        }

        for (int i = 11; i <= 20; i++) {
            System.out.println("Тест " + i + ": Имитация работы с файлами");
            fileOperation();
            System.out.println("Тест " + i + " завершен\n");
        }

        for (int i = 21; i <= 30; i++) {
            System.out.println("Тест " + i + ": Имитация сетевой активности");
            networkActivity();
            System.out.println("Тест " + i + " завершен\n");
        }
    }

    private static void heavyComputation() {
        for (int i = 0; i < 1000000; i++) {
            Math.sqrt(i);
        }
    }

    private static void fileOperation() {
        
        try {
            
            File tempFile = File.createTempFile("testfile", ".txt");
            String content = "Test file content";
            Files.write(Paths.get(tempFile.getAbsolutePath()), content.getBytes());

            
            byte[] bytes = Files.readAllBytes(Paths.get(tempFile.getAbsolutePath()));
            System.out.println("Read from file: " + new String(bytes));

            Files.deleteIfExists(Paths.get(tempFile.getAbsolutePath()));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void networkActivity() {
        try {
            URL url = new URL("https://www.example.com");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            int responseCode = connection.getResponseCode();
            System.out.println("HTTP GET request to www.example.com. Response code: " + responseCode);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
