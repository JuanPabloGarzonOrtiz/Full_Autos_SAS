using System;
using Internal;
using MySql.Data.MySqlClient;

using System.Collections.Generic;
using System.Text.Json;


namespace APIDatabase{
    public class Registro{
        public string Nombre { get; set; } = "";
        public string Foto { get; set; } = "";
        public string Descripcion { get; set; } = "";
        public string Tipo { get; set; } = "";
        public string Tiempo { get; set; } = "";
        public string Materiales { get; set; } = "";
        public string Precio { get; set; } = "";
        public string Cargo { get; set; } = "";
        public string Fecha { get; set; } = "";
        public string Año { get; set; } = "";
    }

    public class DbConection{
        private const string ConnectionString = "Server=gateway01.us-east-1.prod.aws.tidbcloud.com;Port=4000;Database=Full_Autos_SAS;Uid=4PqHVCMYFFYecnt.root;Pwd=ubLIg4hDjWTJbte8;";

        public static  async Task<string> Query(string consulta, string secction){
            var resultados = new List<Registro>();
            try{
                //Conexion a la DB
                using var conn = new MySqlConnection(ConnectionString);
                await conn.OpenAsync();
                
                //Consulta
                var query = new MySqlCommand(consulta, conn);
                using var reader = await query.ExecuteReaderAsync();

                //Datos Obtenidos
                while (await reader.ReadAsync()){
                    if (secction == "data_Service"){
                        resultados.Add(new Registro{
                            Nombre = reader["nombre"].ToString(),
                            Foto = reader["foto"].ToString(),
                            Descripcion = reader["descripcion"].ToString(),
                            Tipo = reader["tipo"].ToString(),
                            Tiempo = reader["tiempo"].ToString(),
                            Materiales = reader["materiales"].ToString(),
                            Precio = reader["precio"].ToString()
                        });
                    }else if (secction == "list_Services"){
                        resultados.Add(new Registro{
                            Nombre = reader["nombre"].ToString(),
                            Foto = reader["foto"].ToString(),
                            Tipo = reader["tipo"].ToString(),
                        });
                    }else if (secction == "list_Tec"){
                        resultados.Add(new Registro{
                            Nombre = reader["nombre"].ToString(),
                            Cargo = reader["cargo"].ToString(),
                            Foto = reader["foto"].ToString()
                        });
                    }else if (secction == "list_Trayectoria"){
                        resultados.Add(new Registro{
                            Fecha = reader["fecha"].ToString(),
                            Año = reader["año"].ToString(),
                            Descripcion = reader["descripcion"].ToString()
                        });
                    }
                }
            }catch (Exception ex){
                resultados.Add(new Registro { Nombre = "Error", Tipo = ex.Message });
            }
            return JsonSerializer.Serialize(resultados, new JsonSerializerOptions { WriteIndented = true });
        }

        public static async Task Main(string[] args){
            var json = await Query("select * from Servicios", "list_Services");
            var consulta = JsonSerializer.Deserialize<List<Dictionary<string, string>>>(json);

            foreach (var item in consulta){
                Console.WriteLine(item["Nombre"]);
            }
        }
    }
}
