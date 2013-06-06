/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.buttonClasses
{
	import org.hammerc.controls.Label;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.buttonClasses.AbstractLabelButtonSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractLabelButton</code> 类抽象出带有文本描述的按钮组件应有的属性及方法.
	 * @author wizardc
	 */
	public class AbstractLabelButton extends AbstractButtonBase
	{
		/**
		 * 记录标签对象.
		 */
		protected var _label:Label;
		
		/**
		 * 记录标签的外边距对象.
		 */
		protected var _labelMargin:Margin;
		
		/**
		 * <code>AbstractLabelButton</code> 类为抽象类, 不能被实例化.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function AbstractLabelButton(skinClass:Class = null)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractButtonBase);
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			super.init();
			//设置默认属性
			_labelMargin = new Margin();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			//添加标签对象
			_label = (_skin as AbstractLabelButtonSkin).createLabel();
			_label.mouseEnabled = _label.mouseChildren = false;
			_label.autoSize = false;
			this.addChild(_label);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractLabelButtonSkin;
		}
		
		/**
		 * 设置或获取标签对象使用的皮肤类.
		 */
		public function set labelSkinClass(value:Class):void
		{
			_label.skinClass = value;
		}
		public function get labelSkinClass():Class
		{
			return _label.skinClass;
		}
		
		/**
		 * 获取标签皮肤绘制对象的实例.
		 */
		public function get labelSkin():ISkin
		{
			return _label.skin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onEnabledChanged(enabled:Boolean):void
		{
			super.onEnabledChanged(enabled);
			_label.enabled = enabled;
		}
		
		/**
		 * 设置或获取文本框的外边距对象.
		 */
		public function set labelMargin(value:Margin):void
		{
			_labelMargin = value == null ? new Margin() : value.clone();
			this.invalidateLayout();
		}
		public function get labelMargin():Margin
		{
			return _labelMargin;
		}
		
		/**
		 * 设置或获取标签文本.
		 */
		public function set label(value:String):void
		{
			_label.text = value;
		}
		public function get label():String
		{
			return _label.text;
		}
		
		/**
		 * 设置或获取标签的对齐方式.
		 */
		public function set labelAlign(value:String):void
		{
			_label.align = value;
		}
		public function get labelAlign():String
		{
			return _label.align;
		}
		
		/**
		 * 设置或获取标签是否为粗体字.
		 */
		public function set labelBold(value:Boolean):void
		{
			_label.bold = value;
		}
		public function get labelBold():Boolean
		{
			return _label.bold;
		}
		
		/**
		 * 设置或获取标签文本的颜色.
		 */
		public function set labelColor(value:uint):void
		{
			_label.textColor = value;
		}
		public function get labelColor():uint
		{
			return _label.textColor;
		}
		
		/**
		 * 设置或获取标签是否使用嵌入字体轮廓进行呈现.
		 */
		public function set labelEmbedFonts(value:Boolean):void
		{
			_label.embedFonts = value;
		}
		public function get labelEmbedFonts():Boolean
		{
			return _label.embedFonts;
		}
		
		/**
		 * 设置或获取标签字体名称.
		 */
		public function set labelFontName(value:String):void
		{
			_label.fontName = value;
		}
		public function get labelFontName():String
		{
			return _label.fontName;
		}
		
		/**
		 * 设置或获取标签文本的大小.
		 */
		public function set labelFontSize(value:Number):void
		{
			_label.fontSize = value;
		}
		public function get labelFontSize():Number
		{
			return _label.fontSize;
		}
		
		/**
		 * 设置或获取标签文本是否为斜体.
		 */
		public function set labelItalic(value:Boolean):void
		{
			_label.italic = value;
		}
		public function get labelItalic():Boolean
		{
			return _label.italic;
		}
		
		/**
		 * 设置或获取标签文本是否带下划线.
		 */
		public function set labelUnderline(value:Boolean):void
		{
			_label.underline = value;
		}
		public function get labelUnderline():Boolean
		{
			return _label.underline;
		}
		
		/**
		 * 获取标签对象.
		 */
		hammerc_internal function get labelInstance():Label
		{
			return _label;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout():void
		{
			var labelWidth:Number = _width - _labelMargin.left - _labelMargin.right;
			var labelHeight:Number = _height - _labelMargin.top - _labelMargin.bottom;
			_label.setLocation(_labelMargin.left, _labelMargin.top);
			_label.setSize(labelWidth, labelHeight);
		}
		
		/**
		 * 设置按钮对象的尺寸匹配标签文本.
		 * @param changeWidth 改变宽度匹配标签文本.
		 * @param changeHeight 改变高度匹配标签文本.
		 */
		public function adjustSizeWithLabel(changeWidth:Boolean = true, changeHeight:Boolean = true):void
		{
			if(changeWidth || changeHeight)
			{
				_label.autoSize = true;
				_label.autoSize = false;
				var width:Number = this.width;
				var height:Number = this.height;
				if(changeWidth)
				{
					width = _labelMargin.left + _label.width + _labelMargin.right;
				}
				if(changeHeight)
				{
					height = _labelMargin.top + _label.height + _labelMargin.bottom;
				}
				this.setSize(width, height);
			}
		}
		
		/**
		 * 垂直居中标签.
		 * <p>该方法会改变 <code>labelMargin</code> 属性对象的 <code>top</code> 及 <code>bottom</code> 属性.</p>
		 */
		public function veticallyLabel():void
		{
			_label.autoSize = true;
			_label.autoSize = false;
			var labelHeight:Number = _label.height;
			_labelMargin.top = (_height - labelHeight) / 2;
			_labelMargin.bottom = _height - (_labelMargin.top + labelHeight);
			this.invalidateLayout();
		}
	}
}
