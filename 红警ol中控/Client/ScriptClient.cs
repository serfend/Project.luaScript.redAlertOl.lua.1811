using DotNet4.Utilities.UtilReg;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace 红警ol中控.Client
{
	/// <summary>
	/// 假设终端指定运行同一种号，此号的属性由服务器进行设置
	/// </summary>
	public class ScriptClient
	{
		public const string LatestVersion = "0.1.1";
		public const string NewVersionDescription = "新的版本已发布\n发布时间:2018-12-05\n新增功能:暂无描述,加群:489518369了解更多";
		private string clientDeviceId;
		private string version;

		private Reg info;
		public ScriptClient(string clientDeviceId)
		{
			this.clientDeviceId = clientDeviceId;
			info = new Reg().In("Client").In(clientDeviceId);
		}
		public string Name { get => info.GetInfo("Name"); set => info.SetInfo("Name", value); }
		/// <summary>
		/// 获取常规设置
		/// </summary>
		/// <param name="path">例如 </param>
		/// <returns></returns>
		public string GetServerSetting(string path)
		{
			return "<XML>";
		}
		public string ClientDeviceId { get => clientDeviceId;private set => clientDeviceId = value; }
		public string UserId { get => GetInfo("UserId"); set =>SetInfo("UserId",value); }
		public string Version { get => version; set => version = value; }

		private void SetInfo(string key,string value)
		{
			info.SetInfo(key, value);
		}
		private string GetInfo(string key)
		{
			return info.GetInfo(key);
		}
	}
}
