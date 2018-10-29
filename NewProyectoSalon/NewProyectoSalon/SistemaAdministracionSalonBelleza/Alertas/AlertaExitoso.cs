using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SistemaAdministracionSalonBelleza.Alertas
{
    public partial class AlertaExitoso : Form
    {
        public AlertaExitoso()
        {
            InitializeComponent();
        }
        public AlertaExitoso(string msg)
        {
            InitializeComponent();
            lbMessage.Text = msg;
        }
        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
