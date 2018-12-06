using DotNet4.Utilities.UtilCode;
using SfTcp;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using 红警ol中控.Client;

namespace 红警ol中控
{
	public partial class FrmMain : Form
	{
		private TcpServerManager manager;
		private Dictionary<string, ScriptClient> clients=new Dictionary<string, ScriptClient>();
		/// <summary>
		/// 初始化服务器
		/// </summary>
		private void InitServer()
		{
			TcpServer.UseAesTransport = false;//TODO 暂时不使用加密
			manager = new TcpServerManager() {
				ServerConnected = NewClient,
				ServerDisconnected = DisConnectClient,
				NormalMessage = ClientMessage
			};
		}
		private void NewClient(TcpServer client)
		{
			var data = new string[12];
			data[3] = client.Ip;
			this.Invoke((EventHandler) delegate{ LstScriptInfo.Items.Add(new ListViewItem(data)); });
			var t = new Task(()=> {
				Thread.Sleep(3000);
				client.Send($"<welcome>{HttpUtil.TimeStamp}</welcome>");
			});
			t.Start();
			client.Send("<ClientInit>");//初始化终端开始
		}
		private void DisConnectClient(TcpServer client)
		{
			var item = GetItemOnLstClient(client.Ip);
			if(item!=null)
				this.Invoke((EventHandler)delegate { LstScriptInfo.Items.Remove(item); });
		}
		private void ClientMessage(TcpServer client,string Title,string Info)
		{
			var item = GetItemOnLstClient(client.Ip);
			var response = new StringBuilder();
			if (item == null)
			{
				MessageBox.Show($"未知来源的终端发送消息:{Title}\n{Info}");
			}
			switch (Title)
			{
				case "ScriptClientInit": {
						var version = HttpUtil.GetElementInItem(Info, "ver");
						var UserId = HttpUtil.GetElementInItem(Info,"User");
						var clientId = HttpUtil.GetElementInItem(Info, "ID");
						var scriptClient = new ScriptClient(clientId) {
							Version= version
						};
						if (ScriptClient.LatestVersion != version) response.Append($"<newVersion><ver>{ScriptClient.LatestVersion}</ver><des>{ScriptClient.NewVersionDescription}</des></newVersion>");
						var clientName = HttpUtil.GetElementInItem(Info, "Name");
						if (scriptClient.Name == "") scriptClient.Name = clientName;
						else if (clientName != scriptClient.Name) response.Append($"<setName>{scriptClient.Name}</setName>");
						
						break;
					}
				case "Status": {
						this.Invoke((EventHandler)delegate {
							item.SubItems[2].Text=Info;
						});
						break;
					}
				case "heartBeat": {
						break;
					}
				case "AllSetting":
					{
						Console.WriteLine(Info);
						break;
					}
			}
			if (response.Length > 0) client.Send(response.ToString());
		}
	}
}
