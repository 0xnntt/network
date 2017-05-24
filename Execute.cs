using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Diagnostics;
using System.Security;

public static string ExecuteCommand(string arguments)

        {
            string output = "";

            try
            {
                ProcessStartInfo ps = new ProcessStartInfo();
                ps.FileName = "c"+"md"+".exe";
                ps.Arguments = string.Format("/C {0}", arguments);
                ps.UseShellExecute = false;
                ps.RedirectStandardOutput = true;
                ps.CreateNoWindow = true;
                using (Process ps1 = Process.Start(ps))
                {

                    using (StreamReader reader = ps1.StandardOutput)
                    {
                        output = reader.ReadToEnd();
                    }
                    ps1.WaitForExit(5000);                                      //  5 seconds wait for command result
                }


            }
            catch (System.Exception ex)
            {

            }


            return output;
        }
