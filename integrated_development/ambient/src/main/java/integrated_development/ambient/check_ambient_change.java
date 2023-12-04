package integrated_development.ambient;
import com.google.common.io.Files;
import com.intellij.ide.actions.QuickChangeLookAndFeel;
import com.intellij.ide.AppLifecycleListener;
import com.intellij.ide.ui.LafManager;
import com.intellij.openapi.actionSystem.*;
import com.intellij.openapi.application.Application;
import com.intellij.openapi.application.ApplicationManager;
import com.intellij.openapi.application.PathManager;
import com.intellij.openapi.diagnostic.Logger;
import com.intellij.openapi.project.Project;
import com.intellij.openapi.util.Ref;
import java.io.IOException;
import java.lang.InterruptedException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import com.intellij.openapi.editor.colors.EditorColorsManager;
import com.intellij.openapi.editor.colors.EditorColorsScheme;
import org.jetbrains.annotations.NotNull;
import javax.swing.*;


class check_ambient_change implements AppLifecycleListener
{

    static boolean m_bStarted = false;

    String m_strLastCurrentTheme;


    @Override
    public void appFrameCreated(@NotNull List<String> commandLineArgs)
    {

        if(m_bStarted)
        {

            return;

        }

        m_bStarted = true;

        ApplicationManager.getApplication().executeOnPooledThread(
                new Runnable()
            {

                public void run()
                {

                    try
                    {

                        Thread.sleep(5000);

                        m_strLastCurrentTheme = current_theme();

                        while (true)
                        {

                            check_ambient_change_step();

                            Thread.sleep(1000);

                        }

                    }
                    catch(InterruptedException e)
                    {

                        logger().info("check_ambient_change runnable interrupted");

                    }

                }

            }
            );

    }

    @NotNull
    private static Logger logger()
    {

        return Logger.getInstance(check_ambient_change.class);

    }


    public Path settings_folder()
    {

        String strHome = PathManager.getPluginsPath();

        Path path = Paths.get(strHome, "ambient");

        return path;

    }

    public Path ambient_setting_path()
    {

        String strHome = System.getProperty("user.home");

        Path path = Paths.get(strHome, ".ambient", "ambient.txt");

        return path;

    }

    public Path written_settings_path()
    {

        Path path = Paths.get(settings_folder().toAbsolutePath().toString(), current_ambient() + ".txt");

        return path;

    }

    public void defer_ensure_settings_folder()
    {

        if(!java.nio.file.Files.isDirectory(settings_folder()))
        {

            try
            {

                java.nio.file.Files.createDirectories(settings_folder());

            }
            catch(IOException e)
            {

                logger().warn("Failed to create settings folder");

            }

        }

    }

    public String current_ambient()
    {

        String strCurrentAmbient = "";

        try
        {

            strCurrentAmbient = java.nio.file.Files.readString(ambient_setting_path(), StandardCharsets.UTF_8);

        }
        catch(IOException e)
        {

            logger().warn("Failed to read file \"" + ambient_setting_path() + "\"");

        }

        //logger().info("check_ambient_change_step: path=\"" + ambient_setting_path() + "\"");
        //logger().info("check_ambient_change_step: content=\"" + strCurrentAmbient + "\"");

        return strCurrentAmbient;

    }

    public String current_scheme()
    {

        defer_ensure_settings_folder();

        EditorColorsManager editorColorsManager = EditorColorsManager.getInstance();

        EditorColorsScheme scheme = null;

        try
        {

            scheme = editorColorsManager.getSchemeForCurrentUITheme();

        }
        catch(AssertionError e)
        {

        }

        if (scheme == null)
        {

            return "";

        }

        String strCurrentScheme = scheme.getName();

        return strCurrentScheme;

    }

    public String current_look_and_feel()
    {

        LafManager lafManager = LafManager.getInstance();

        UIManager.LookAndFeelInfo lookAndFeelInfo = lafManager.getCurrentLookAndFeel();

        if(lookAndFeelInfo == null)
        {

            return "";

        }

        String strCurrentLookAndFeel;

        strCurrentLookAndFeel = lookAndFeelInfo.getName();

        return strCurrentLookAndFeel;

    }


    public String current_theme()
    {

        String strCurrentScheme = current_scheme();

        String strCurrentLookAndFeel = current_look_and_feel();

        String strCurrentTheme;

        strCurrentTheme = strCurrentScheme + "," + strCurrentLookAndFeel;

        //logger().info("current_theme=\"" + strCurrentTheme + "\"");

        return strCurrentTheme;

    }

    public UIManager.LookAndFeelInfo get_look_and_feel(String strLookAndFeel)
    {

        LafManager lafManager = LafManager.getInstance();

        UIManager.LookAndFeelInfo[] installedLookAndFeels = lafManager.getInstalledLookAndFeels();

        for (UIManager.LookAndFeelInfo lookAndFeel : installedLookAndFeels)
        {

            String strName = lookAndFeel.getName();

            if (strName.equals(strLookAndFeel))
            {

                return lookAndFeel;

            }

        }

        return null;

    }


    public void defer_set_new_theme(String strNewTheme)
    {

        try
        {

            set_new_theme(strNewTheme);

        }
        catch(InterruptedException e)
        {

        }

    }


    public void set_new_theme(String strNewTheme) throws InterruptedException
    {

        String new_lines[] = strNewTheme.split(",");

        if (new_lines.length < 2)
        {

            logger().info("set_new_theme \"" + strNewTheme + "\" theme name doesn't have two components separated by comma");

            return;

        }

        String strNewScheme = new_lines[0];

        String strNewLookAndFeel = new_lines[1];

        String strCurrentLookAndFeel = current_look_and_feel();

        if(!strCurrentLookAndFeel.equals(strNewLookAndFeel))
        {

            final LafManager lafManager = LafManager.getInstance();

            UIManager.LookAndFeelInfo lookAndFeelInfoNew = get_look_and_feel(strNewLookAndFeel);

            if(lookAndFeelInfoNew == null)
            {

                logger().info("look_and_feel=\"" + strNewLookAndFeel + "\" doesn't exist");

            }
            else
            {

                logger().info("setting new theme look_and_feel=\"" + strNewLookAndFeel + "\"");

                QuickChangeLookAndFeel.switchLafAndUpdateUI(lafManager, lookAndFeelInfoNew, true);

                Thread.sleep(5000);

            }

        }

        String strCurrentScheme = current_scheme();

        if (!strCurrentScheme.equals(strNewScheme))
        {

            EditorColorsManager editorColorsManager = EditorColorsManager.getInstance();

            EditorColorsScheme schemeNew = editorColorsManager.getScheme(strNewScheme);

            if(schemeNew == null)
            {

                logger().info("scheme=\"" + strNewScheme + "\" doesn't exist");

            }
            else
            {

                logger().info("setting new theme scheme=\"" + strNewScheme + "\"");

                editorColorsManager.setGlobalScheme(schemeNew);

                Thread.sleep(5000);

            }

        }

    }


    public String read_written_theme()
    {

        String strNewTheme = "";

        try
        {

            strNewTheme = java.nio.file.Files.readString(written_settings_path(), StandardCharsets.UTF_8);

        }
        catch(IOException e)
        {

            logger().warn("Failed to read file \"" + written_settings_path() + "\"");

        }

        //logger().info("check_ambient_change_step: theme_reading.txt path=\"" + settings_reading_path() + "\"");
        //logger().info("check_ambient_change_step: theme_reading.txt content=\"" + strNewTheme + "\"");

        return strNewTheme;

    }

    public void check_ambient_change_step()
    {

        String strCurrentTheme = current_theme();

        if(!strCurrentTheme.equals(m_strLastCurrentTheme))
        {

            if (m_strLastCurrentTheme != null)
            {

                try
                {

                    String strWrittenTheme = read_written_theme();

                    if(!strWrittenTheme.equals(strCurrentTheme))
                    {

                        java.nio.file.Files.writeString(written_settings_path(), strCurrentTheme);

                    }

                }
                catch (IOException e)
                {

                    logger().warn("Failed to write \""+ strCurrentTheme + "\" to file \"" + written_settings_path() + "\"");

                }

            }

            m_strLastCurrentTheme = strCurrentTheme;

        }

       //logger().info("check_ambient_change_step: written_theme.txt path=\"" + written_settings_path() + "\"");

        String strNewTheme = read_written_theme();

        if(!strNewTheme.equals(strCurrentTheme) && strNewTheme.length() > 0)
        {

            SwingUtilities.invokeLater(() -> defer_set_new_theme(strNewTheme));

        }

    }

}