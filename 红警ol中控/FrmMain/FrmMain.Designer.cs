namespace 红警ol中控
{
	public partial class FrmMain
	{
		/// <summary>
		/// 必需的设计器变量。
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// 清理所有正在使用的资源。
		/// </summary>
		/// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows 窗体设计器生成的代码

		/// <summary>
		/// 设计器支持所需的方法 - 不要修改
		/// 使用代码编辑器修改此方法的内容。
		/// </summary>
		private void InitializeComponent()
		{
			this.TabMain = new System.Windows.Forms.TabControl();
			this.TabMain_Monitor = new System.Windows.Forms.TabPage();
			this.LstScriptInfo = new System.Windows.Forms.ListView();
			this.LstScriptInfo_ID = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_User = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Status = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Port = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Ver = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Energy = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Gold = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Res1 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Res2 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Res3 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Res4 = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Comsume = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.LstScriptInfo_Protect = ((System.Windows.Forms.ColumnHeader)(new System.Windows.Forms.ColumnHeader()));
			this.TabMain_User = new System.Windows.Forms.TabPage();
			this.button1 = new System.Windows.Forms.Button();
			this.TabMain.SuspendLayout();
			this.TabMain_Monitor.SuspendLayout();
			this.SuspendLayout();
			// 
			// TabMain
			// 
			this.TabMain.Controls.Add(this.TabMain_Monitor);
			this.TabMain.Controls.Add(this.TabMain_User);
			this.TabMain.Location = new System.Drawing.Point(8, 8);
			this.TabMain.Name = "TabMain";
			this.TabMain.SelectedIndex = 0;
			this.TabMain.Size = new System.Drawing.Size(967, 901);
			this.TabMain.TabIndex = 0;
			// 
			// TabMain_Monitor
			// 
			this.TabMain_Monitor.Controls.Add(this.button1);
			this.TabMain_Monitor.Controls.Add(this.LstScriptInfo);
			this.TabMain_Monitor.Location = new System.Drawing.Point(4, 22);
			this.TabMain_Monitor.Name = "TabMain_Monitor";
			this.TabMain_Monitor.Padding = new System.Windows.Forms.Padding(3);
			this.TabMain_Monitor.Size = new System.Drawing.Size(959, 875);
			this.TabMain_Monitor.TabIndex = 0;
			this.TabMain_Monitor.Text = "终端连接";
			this.TabMain_Monitor.UseVisualStyleBackColor = true;
			// 
			// LstScriptInfo
			// 
			this.LstScriptInfo.Columns.AddRange(new System.Windows.Forms.ColumnHeader[] {
            this.LstScriptInfo_ID,
            this.LstScriptInfo_User,
            this.LstScriptInfo_Status,
            this.LstScriptInfo_Port,
            this.LstScriptInfo_Ver,
            this.LstScriptInfo_Energy,
            this.LstScriptInfo_Gold,
            this.LstScriptInfo_Res1,
            this.LstScriptInfo_Res2,
            this.LstScriptInfo_Res3,
            this.LstScriptInfo_Res4,
            this.LstScriptInfo_Comsume,
            this.LstScriptInfo_Protect});
			this.LstScriptInfo.Location = new System.Drawing.Point(6, 6);
			this.LstScriptInfo.Name = "LstScriptInfo";
			this.LstScriptInfo.Size = new System.Drawing.Size(947, 566);
			this.LstScriptInfo.TabIndex = 0;
			this.LstScriptInfo.UseCompatibleStateImageBehavior = false;
			this.LstScriptInfo.View = System.Windows.Forms.View.Details;
			// 
			// LstScriptInfo_ID
			// 
			this.LstScriptInfo_ID.Text = "ID";
			this.LstScriptInfo_ID.Width = 65;
			// 
			// LstScriptInfo_User
			// 
			this.LstScriptInfo_User.Text = "归属";
			this.LstScriptInfo_User.Width = 121;
			// 
			// LstScriptInfo_Status
			// 
			this.LstScriptInfo_Status.Text = "状态";
			this.LstScriptInfo_Status.Width = 156;
			// 
			// LstScriptInfo_Port
			// 
			this.LstScriptInfo_Port.Text = "端口";
			this.LstScriptInfo_Port.Width = 48;
			// 
			// LstScriptInfo_Ver
			// 
			this.LstScriptInfo_Ver.Text = "版本";
			this.LstScriptInfo_Ver.Width = 72;
			// 
			// LstScriptInfo_Energy
			// 
			this.LstScriptInfo_Energy.Text = "体力值";
			// 
			// LstScriptInfo_Gold
			// 
			this.LstScriptInfo_Gold.Text = "金币";
			// 
			// LstScriptInfo_Res1
			// 
			this.LstScriptInfo_Res1.Text = "矿石";
			// 
			// LstScriptInfo_Res2
			// 
			this.LstScriptInfo_Res2.Text = "石油";
			// 
			// LstScriptInfo_Res3
			// 
			this.LstScriptInfo_Res3.Text = "合金";
			// 
			// LstScriptInfo_Res4
			// 
			this.LstScriptInfo_Res4.Text = "稀土";
			this.LstScriptInfo_Res4.Width = 59;
			// 
			// LstScriptInfo_Comsume
			// 
			this.LstScriptInfo_Comsume.Text = "采集道具";
			// 
			// LstScriptInfo_Protect
			// 
			this.LstScriptInfo_Protect.Text = "保护罩";
			// 
			// TabMain_User
			// 
			this.TabMain_User.Location = new System.Drawing.Point(4, 22);
			this.TabMain_User.Name = "TabMain_User";
			this.TabMain_User.Padding = new System.Windows.Forms.Padding(3);
			this.TabMain_User.Size = new System.Drawing.Size(959, 875);
			this.TabMain_User.TabIndex = 1;
			this.TabMain_User.Text = "用户管理";
			this.TabMain_User.UseVisualStyleBackColor = true;
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(6, 578);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(132, 40);
			this.button1.TabIndex = 1;
			this.button1.Text = "详细信息";
			this.button1.UseVisualStyleBackColor = true;
			// 
			// FrmMain
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(979, 921);
			this.Controls.Add(this.TabMain);
			this.Name = "FrmMain";
			this.TabMain.ResumeLayout(false);
			this.TabMain_Monitor.ResumeLayout(false);
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.TabControl TabMain;
		private System.Windows.Forms.TabPage TabMain_Monitor;
		private System.Windows.Forms.ListView LstScriptInfo;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_ID;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_User;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Status;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Port;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Ver;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Energy;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Gold;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Res1;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Res2;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Res3;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Res4;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Comsume;
		private System.Windows.Forms.ColumnHeader LstScriptInfo_Protect;
		private System.Windows.Forms.TabPage TabMain_User;
		private System.Windows.Forms.Button button1;
	}
}

