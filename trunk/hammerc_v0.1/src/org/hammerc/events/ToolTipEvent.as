/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.events
{
	import flash.events.Event;
	
	import org.hammerc.controls.render.IToolTipRender;
	
	/**
	 * <code>ToolTipEvent</code> 类为工具提示的事件类.
	 * @author wizardc
	 */
	public class ToolTipEvent extends Event
	{
		/**
		 * 当工具提示对象出现时会播放该事件.
		 * <p>此事件具有以下属性:</p>
		 * <table class="innertable">
		 *   <tr><th>Property</th><th>Value</th></tr>
		 *   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>cancelable</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>currentTarget</code></td><td>当前正在使用某个事件侦听器处理该事件的对象.</td></tr>
		 *   <tr><td><code>target</code></td><td>发送该事件的对象.</td></tr>
		 *   <tr><td><code>toolTip</code></td><td>对应的工具提示对象.</td></tr>
		 * </table>
		 * @eventType toolTipShow
		 */
		public static const TOOL_TIP_SHOW:String = "toolTipShow";
		
		/**
		 * 当工具提示对象消失时会播放该事件.
		 * <p>此事件具有以下属性:</p>
		 * <table class="innertable">
		 *   <tr><th>Property</th><th>Value</th></tr>
		 *   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>cancelable</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>currentTarget</code></td><td>当前正在使用某个事件侦听器处理该事件的对象.</td></tr>
		 *   <tr><td><code>target</code></td><td>发送该事件的对象.</td></tr>
		 *   <tr><td><code>toolTip</code></td><td>对应的工具提示对象.</td></tr>
		 * </table>
		 * @eventType toolTipHide
		 */
		public static const TOOL_TIP_HIDE:String = "toolTipHide";
		
		/**
		 * 记录对应的工具提示对象.
		 */
		protected var _toolTip:IToolTipRender;
		
		/**
		 * 创建一个 <code>ToolTipEvent</code> 对象.
		 * @param type 事件的类型.
		 */
		public function ToolTipEvent(type:String, toolTip:IToolTipRender)
		{
			super(type, false, false);
			_toolTip = toolTip;
		}
		
		/**
		 * 获取对应的工具提示对象.
		 */
		public function get toolTip():IToolTipRender
		{
			return _toolTip;
		}
		
		/**
		 * 创建本事件对象的副本, 并设置每个属性的值以匹配原始属性值.
		 * @return 其属性值与原始属性值匹配的新对象.
		 */
		override public function clone():Event
		{
			return new ToolTipEvent(this.type, this.toolTip);
		}
		
		/**
		 * 返回一个描述本对象的字符串.
		 * @return 一个字符串, 其中包含本对象的描述.
		 */
		override public function toString():String
		{
			return formatToString("ToolTipEvent", "type", "bubbles", "cancelable", "toolTip");
		}
	}
}
