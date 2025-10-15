
using System;
using APIDatabase;
using System.Collections.Generic;
using System.Text.Json;
using System.Threading.Tasks;    
using Microsoft.Maui.Dispatching;
using Internal;
namespace AppMaui{
    public partial class MainPage : ContentPage{
        public MainPage(){
            InitializeComponent();
            String url = "https://www.google.com/maps/@4.7110,-74.0721,12z";
            MyWebView.Source = url;

            //Servicios
            var json_Services =  DbConection.Query("SELECT nombre, foto, tipo FROM Servicios;", "list_Services");
            json_Services.ContinueWith(async data_Services => {
                if (data_Services.IsCompletedSuccessfully) {
                    var query_Services = JsonSerializer.Deserialize<List<Dictionary<string, string>>>(data_Services.Result);
                    //Agrupar Servicios
                    var tipos = new Dictionary<string, List<string>>();
                    foreach (var item in query_Services){
                        var tipo = item["Tipo"];
                        if (!tipos.ContainsKey(tipo)){
                            tipos[tipo] = new List<string>();
                        }   
                        tipos[tipo].Add(item["Nombre"]);
                    }

                    MainThread.BeginInvokeOnMainThread(() =>{
                        int count = 0;
                        foreach (var tipo in tipos){   
                            //Definicion de Titulo de Seccion de Productos
                            section_Services.Children.Add(
                                new Label{
                                    Text = tipo.Key,
                                    TextColor = Color.FromArgb("#E7B694"),
                                    FontSize = 20,
                                    HorizontalTextAlignment = (count % 2 == 0) 
                                        ? TextAlignment.Start 
                                        : TextAlignment.End
                                }
                            );                     
                            count += 1;
                            var horizontalLayout = new HorizontalStackLayout { Spacing = 20, Margin = 10 };
                            foreach (var service in tipo.Value){
                                var verticalLayout = new VerticalStackLayout{
                                    WidthRequest = 200, 
                                    HorizontalOptions = LayoutOptions.Center
                                };
                                //Definicion de Imagen de Producto
                                verticalLayout.Children.Add(
                                    new ImageButton{
                                        Source = "product_defect.png",
                                        BackgroundColor = Colors.Transparent,
                                        WidthRequest = 200,
                                        HeightRequest = 200,
                                        Command = new Command((object sender) => OnOpenServiceClicked(service))
                                    }
                                );
                                //Definicion de Nombre de Producto
                                verticalLayout.Children.Add(
                                    new Label { Text = service, TextColor = Colors.White, FontSize = 18, HorizontalTextAlignment = TextAlignment.Center }
                                );
                                horizontalLayout.Children.Add(verticalLayout);
                            }
                            var scroll = new ScrollView{
                                Orientation = ScrollOrientation.Horizontal,
                                Content = horizontalLayout
                            };
                            section_Services.Children.Add(scroll);
                        }
                    });
                }
            }).ContinueWith(async data_Trayectoria => {
                //Trayectoria
                if (data_Trayectoria.IsCompletedSuccessfully) { 
                    var json_Trayectoria = await DbConection.Query("SELECT fecha, SUBSTR(fecha,1,INSTR(fecha, '-') -1) AS año, descripcion FROM Datos_Trayectoria ORDER BY año ASC;", "list_Trayectoria");
                    var query_Trayectoria = JsonSerializer.Deserialize<List<Dictionary<string, string>>>(json_Trayectoria);
                    MainThread.BeginInvokeOnMainThread(() =>{
                        // Linea de Trayectoria
                        var linea_Tiempo = new HorizontalStackLayout { Spacing = 0, HorizontalOptions = LayoutOptions.Center ,Margin = 10 };
                        for (int i = 0 ; i < query_Trayectoria.Count; i ++){
                            var año_Section = new VerticalStackLayout { Spacing = 5, HorizontalOptions = LayoutOptions.Center };

                            // Año encima del círculo
                            año_Section.Children.Add(
                                new Label{
                                    Text = query_Trayectoria[i]["Año"],
                                    TextColor = Color.FromArgb("#E7B694"),
                                    FontSize = 20,
                                    HorizontalTextAlignment = TextAlignment.Center
                                }
                            );
                            // Contenedor horizontal: línea + círculo + línea
                            var horizontal_Part = new HorizontalStackLayout { Spacing = 0 };

                            // Línea izquierda (no se muestra en el primero)
                            if (i > 0){
                                horizontal_Part.Children.Add(
                                    new BoxView{
                                        Color = Color.FromArgb("#7B3709"),
                                        WidthRequest = 60,
                                        HeightRequest = 4,
                                        VerticalOptions = LayoutOptions.Center
                                    }
                                );
                            }

                            // Círculo (punto del timeline)
                            horizontal_Part.Children.Add(
                                new Frame{
                                    CornerRadius = 15,
                                    WidthRequest = 30,
                                    HeightRequest = 30,
                                    BackgroundColor = Color.FromArgb("#E7B694"),
                                    BorderColor = Color.FromArgb("#7B3709"),
                                    Padding = 0,
                                    HasShadow = true
                                }
                            );

                            // Línea derecha (no se muestra en el último)
                            if (i < query_Trayectoria.Count - 1){
                                horizontal_Part.Children.Add(
                                    new BoxView{
                                        Color = Color.FromArgb("#7B3709"),
                                        WidthRequest = 60,
                                        HeightRequest = 4,
                                        VerticalOptions = LayoutOptions.Center
                                    }
                                );
                            }
                            año_Section.Children.Add(horizontal_Part);
                            linea_Tiempo.Children.Add(año_Section);
                        }
                        // Añadir la linea de tiempo
                        var scroll_Linea_Tiempo = new ScrollView { 
                            Orientation = ScrollOrientation.Horizontal,
                            Content = linea_Tiempo,
                            HorizontalOptions = LayoutOptions.Fill
                        };
                        section_Trayectoria.Children.Add(scroll_Linea_Tiempo);

                        // Detalles de Trayectoria
                        int count = 0;
                        foreach (var item in query_Trayectoria){
                            var alineacion = (count % 2 == 0) 
                                ? TextAlignment.Start 
                                : TextAlignment.End;
                            count += 1;
                            section_Trayectoria.Children.Add(
                                new Label{
                                    Text = item["Año"],
                                    TextColor = Color.FromArgb("#E7B694"),
                                    FontSize = 20,
                                    HorizontalTextAlignment = alineacion
                                }
                            );
                            section_Trayectoria.Children.Add(
                                new Label{
                                    Text = item["Descripcion"],
                                    TextColor = Color.FromArgb("#FFFFFF"),
                                    FontSize = 15,
                                    HorizontalTextAlignment = alineacion
                                }
                            );
                        }
                    });
                }
            });
        }

        //Llamada al Menu de Navegación
        private void OnOpenMenuClicked(object sender, EventArgs e){
            Shell.Current.FlyoutIsPresented = true;
        }
        private async void OnOpenServiceClicked(string name){
            await Shell.Current.GoToAsync($"//ServicePage?name={name}");
        }
        private async void OnOpenFormClicked(object sender, EventArgs e){
            await Shell.Current.GoToAsync("//PostulationPage");
        }
    }
}