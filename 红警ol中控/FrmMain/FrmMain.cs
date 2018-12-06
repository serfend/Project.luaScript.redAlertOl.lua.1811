using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace 红警ol中控
{
	public partial class FrmMain : Form
	{
		public FrmMain()
		{
			InitializeComponent();
			InitServer();
		}
		private ListViewItem GetItemOnLstClient(string ip)
		{
			ListViewItem item=null;
			this.Invoke((EventHandler)delegate {
				for (int i = 0; i < LstScriptInfo.Items.Count; i++)
				{
					if (ip == LstScriptInfo.Items[i].SubItems[3].Text)//"LstScriptInfo_Port"
					{
						item= LstScriptInfo.Items[i];
						break;
					}
				}
			});
			return item;
		}
	}
}
