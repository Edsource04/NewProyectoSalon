using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Logic.LogicaNegocio;
using Logic;

namespace SistemaAdministracionSalonBelleza.AdministradorAplication
{
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }
        private Login_Logic loginLogica = new Login_Logic();
      
        private void linkpass_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            LoginAdmin admin = new AdministradorAplication.LoginAdmin();
            this.Hide();
            admin.Show();
        }

        private void btnlogin_Click(object sender, EventArgs e)
        {
            if(String.IsNullOrWhiteSpace(txtuser.Text) ||String.IsNullOrWhiteSpace(txtuser.Text))
            {
                Alertas.AlertaError s=new  Alertas.AlertaError("Usuario u Contraseña no se a digitado");
                s.Show();
                return;
            }
            LoginVerificacion(txtuser.Text.Trim(), txtpass.Text.Trim());
        }


        private void LoginVerificacion(string usu,string clave)
        { 
            var p = loginLogica.login(usu,clave);
            if (p == null)
            {
                Alertas.AlertaAdvertencias AD = new Alertas.AlertaAdvertencias("No se Encontro Ningún Usuario Registrado");
                AD.ShowDialog();
                txtuser.Focus();
            } else
            {
             if (p.Usuario == usu && clave == Utility.Decrypt_Query(p.Clave))
            {
                Formularios.FrmMenuPrincipal mp = new Formularios.FrmMenuPrincipal();
                mp.Show();
            }
            }
    }
}
}
