using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
 


using System.Windows.Forms;

namespace SistemaAdministracionSalonBelleza.Forms
{
    public partial class Dashboard : Form
    {
        private int idCodigo { get; set; } 
        public Dashboard()
        {
            InitializeComponent();
           

        }
      //private  FrmMenuPrincipal menuprincipal = new FrmMenuPrincipal();
       
      //  public _ParticipanteRepocitorio p = new _ParticipanteRepocitorio();
      //  public Modelo.Entity.PARTICIPANTE m = new Modelo.Entity.PARTICIPANTE();
        //private bool ValidateCamposLlenos()
        //{
        //    //var ced = CedulaMask.Text.Replace("-","").Replace(" ","");
        //    //var tel = txtTel.Text.Replace("-", "").Replace(" ", "").Replace("1", "");  

        //    //Alertas.AlertaAdvertencias a = new Alertas.AlertaAdvertencias();
        //    //if (!String.IsNullOrWhiteSpace(txtApellidos.Text) ||
        //    //    !String.IsNullOrWhiteSpace(txtNombre.Text)    || 
        //    //    !String.IsNullOrWhiteSpace(ced)               || 
        //    //    !String.IsNullOrWhiteSpace(tel))
        //    //{
        //    //    return true;
        //    //}
            
        //    //else
        //    //{
        //    //    //this.menuprincipal.Show();
        //    //    return false;
        //    //}
           
        //}
        private void btnCerrar_Click(object sender, EventArgs e)
        {
            //var validar = ValidateCamposLlenos();
            //if (validar == true)
            //{
            //    Alertas.AlertaAdvertencias error = new Alertas.AlertaAdvertencias("Existen Campos llenos favor Guardarlo o Cancelar");
            //    error.ShowDialog();
            //} else
            //{
            //    //this.menuprincipal.Show();
            //}

          
        }
        private void label1_Click(object sender, EventArgs e)
        {

        }
        private void button2_Click(object sender, EventArgs e)
        {
            //this.menuprincipal.Show();
           
        }
        private void button3_Click(object sender, EventArgs e)
        {
            GetBuscarParticipanteAll(txtBuscar.Text.Replace("-","").Trim());
                
        }
        private void GetBuscarParticipanteAll(string busqueda)
        {
            //var part = p.GetBuscarParticipanteData(busqueda);
            //GetParticipantesAll.DataSource = part;
        }
        private void GetParticipanteAll()
        {
            //var part = p.GetParticipanteAllData();
            //GetParticipantesAll.DataSource = part;
        }
        private void AddParticipantes (int id, string nombre,string apellidos,string cedula,string telefono)
        {
            //m.id_Participante = id;
            //m.apellidos = apellidos.Trim();
            //m.nombre = nombre.Trim();
            //m.cedula = cedula.Replace("-", "").Trim();
            //m.telefono = telefono.Replace("-","").Trim();
             
            //var repuesta = p.Set_Add_Update_Participantes_Data(m);

            //if (repuesta == 0)
            //{
            //    Alertas.AlertaError error = new Alertas.AlertaError("A ocurrido un error al guardar los datos");
            //    error.ShowDialog();
            //}
            //else
            //{
            //    Alertas.AlertaExitoso exito = new Alertas.AlertaExitoso("El Participante fue Ingresado al sistema");
            //    exito.ShowDialog();
            //    GetParticipanteAll();
            //    ClearCampo();
            //}
            
          
        }
        private void GetArticulosDataDataGrivParticipante_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
        private void Productos_Load(object sender, EventArgs e)
        {
            //GetParticipanteAll();
        }
        private void button1_Click(object sender, EventArgs e)
        {
        //    var a = txtTel.Text;
        //    if (string.IsNullOrWhiteSpace(txtApellidos.Text) || string.IsNullOrWhiteSpace(txtNombre.Text))
        //    {
                
        //        Alertas.AlertaError error = new Alertas.AlertaError("Digite el Apellidos y el Nombre del Participante");
        //        error.ShowDialog();
        //        txtApellidos.Focus();
        //        return;
        //    }
        //    AddParticipantes(
        //        0,
        //        txtApellidos.Text.Trim(),
        //        txtNombre.Text.Trim(),
        //        CedulaMask.Text.Trim(),
        //        txtTel.Text.Trim() );
                 
                
               
        //}
        //private void ClearCampo()
        //{
        //    txtNombre.Text = string.Empty;
        //    txtApellidos.Text = string.Empty;
        //    txtTel.Text = string.Empty;
        //    CedulaMask.Text = string.Empty;

        }
    }
}
