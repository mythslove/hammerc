/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.toolTips
{
	import org.hammerc.containers.Canvas;
	import org.hammerc.controls.Label;
	import org.hammerc.controls.render.IToolTipRender;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.themes.hi.controls.HiLabelSkin;
	
	/**
	 * <code>HiTextToolTipRender</code> 类定义了 Hi 主题的文本工具提示.
	 * @author wizardc
	 */
	public class HiTextToolTipRender extends Canvas implements IToolTipRender
	{
		/**
		 * 记录工具提示的数据.
		 */
		protected var _data:Object;
		
		/**
		 * 记录用于显示文本的标签控件.
		 */
		protected var _label:Label;
		
		/**
		 * 记录标签控件的最大宽度.
		 */
		protected var _maxWidth:Number = 200;
		
		/**
		 * 记录标签控件的外边距对象.
		 */
		protected var _labelMargin:Margin;
		
		/**
		 * 创建一个 <code>HiTextToolTipRender</code> 对象.
		 */
		public function HiTextToolTipRender()
		{
			super(HiTextToolTipBGSkin);
			this.createToolTip();
		}
		
		/**
		 * 创建工具提示的内部对象.
		 */
		protected function createToolTip():void
		{
			_label = new Label(HiLabelSkin);
			this.addElement(_label);
			_labelMargin = new Margin();
			_labelMargin.top = _labelMargin.bottom = 3;
			_labelMargin.left = _labelMargin.right = 5;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set data(value:Object):void
		{
			_data = value;
			this.drawToolTip();
		}
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 * 设置或绘制工具提示对象.
		 */
		protected function drawToolTip():void
		{
			_label.text = _data as String;
			if(_label.width > _maxWidth)
			{
				_label.width = _maxWidth;
				_label.wordWrap = true;
			}
			_label.x = _labelMargin.left;
			_label.y = _labelMargin.top;
			this.width = _labelMargin.left + _label.width + _labelMargin.right;
			this.height = _labelMargin.top + _label.height + _labelMargin.bottom;
		}
		
		/**
		 * @inheritDoc
		 */
		public function show():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function hide():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function reset():void
		{
			_label.wordWrap = false;
		}
	}
}
