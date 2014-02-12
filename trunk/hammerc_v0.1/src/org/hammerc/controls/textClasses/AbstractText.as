/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.textClasses
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.hammerc.controls.core.AbstractUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.controls.textClasses.AbstractTextSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractText</code> 类抽象出显示文本组件应有的属性及方法.
	 * @author wizardc
	 */
	public class AbstractText extends AbstractUIComponent
	{
		/**
		 * 记录组件的文本格式对象.
		 */
		protected var _textFormat:TextFormat;
		
		/**
		 * 记录组件内部显示文本的文本区域对象.
		 */
		protected var _textField:TextField;
		
		/**
		 * <code>AbstractText</code> 类为抽象类, 不能被实例化.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function AbstractText(skinClass:Class = null)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractText);
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_textFormat = new TextFormat();
			_textFormat.align = TextFormatAlign.LEFT;
			_textFormat.bold = false;
			_textFormat.font = null;
			_textFormat.size = 12;
			_textFormat.indent = 0;
			_textFormat.italic = false;
			_textFormat.kerning = false;
			_textFormat.leading = 0;
			_textFormat.leftMargin = 0;
			_textFormat.letterSpacing = 0;
			_textFormat.rightMargin = 0;
			_textFormat.color = 0x000000;
			_textFormat.underline = false;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			_textField = new TextField();
			_textField.embedFonts = false;
			this.addChild(_textField);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractTextSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onEnabledChanged(enabled:Boolean):void
		{
			if(!enabled && this.stage != null && this.stage.focus == _textField)
			{
				this.stage.focus = null;
			}
		}
		
		/**
		 * 设置或获取段落的对齐方式.
		 */
		public function set align(value:String):void
		{
			if(this.align != value)
			{
				_textFormat.align = value;
				this.setTextFormat();
			}
		}
		public function get align():String
		{
			return _textFormat.align;
		}
		
		/**
		 * 设置或获取文本是否为粗体字.
		 */
		public function set bold(value:Boolean):void
		{
			if(this.bold != value)
			{
				_textFormat.bold = value;
				this.setTextFormat();
			}
		}
		public function get bold():Boolean
		{
			return Boolean(_textFormat.bold);
		}
		
		/**
		 * 设置或获取是否使用嵌入字体轮廓进行呈现.
		 */
		public function set embedFonts(value:Boolean):void
		{
			if(_textField.embedFonts != value)
			{
				_textField.embedFonts = value;
				this.setTextFormat();
			}
		}
		public function get embedFonts():Boolean
		{
			return _textField.embedFonts;
		}
		
		/**
		 * 设置或获取字体名称.
		 */
		public function set fontName(value:String):void
		{
			if(this.fontName != value)
			{
				_textFormat.font = value;
				this.setTextFormat();
			}
		}
		public function get fontName():String
		{
			return _textFormat.font;
		}
		
		/**
		 * 设置或获取文本的大小.
		 */
		public function set fontSize(value:Number):void
		{
			if(this.fontSize != value)
			{
				_textFormat.size = value;
				this.setTextFormat();
			}
		}
		public function get fontSize():Number
		{
			return Number(_textFormat.size);
		}
		
		/**
		 * 设置或获取表示从左边距到段落中第一个字符的缩进.
		 */
		public function set indent(value:Number):void
		{
			if(this.indent != value)
			{
				_textFormat.indent = value;
				this.setTextFormat();
			}
		}
		public function get indent():Number
		{
			return Number(_textFormat.indent);
		}
		
		/**
		 * 设置或获取文本是否为斜体.
		 */
		public function set italic(value:Boolean):void
		{
			if(this.italic != value)
			{
				_textFormat.italic = value;
				this.setTextFormat();
			}
		}
		public function get italic():Boolean
		{
			return Boolean(_textFormat.italic);
		}
		
		/**
		 * 获取文本字段中的字符数.
		 */
		public function get length():int
		{
			return _textField.length;
		}
		
		/**
		 * 设置或获取是否启用字距调整.
		 */
		public function set kerning(value:Boolean):void
		{
			if(this.kerning != value)
			{
				_textFormat.kerning = value;
				this.setTextFormat();
			}
		}
		public function get kerning():Boolean
		{
			return Boolean(_textFormat.kerning);
		}
		
		/**
		 * 设置或获取行与行之间的垂直间距.
		 */
		public function set leading(value:Number):void
		{
			if(this.leading != value)
			{
				_textFormat.leading = value;
				this.setTextFormat();
			}
		}
		public function get leading():Number
		{
			return Number(_textFormat.leading);
		}
		
		/**
		 * 设置或获取段落的左边距.
		 */
		public function set leftMargin(value:Number):void
		{
			if(this.leftMargin != value)
			{
				_textFormat.leftMargin = value;
				this.setTextFormat();
			}
		}
		public function get leftMargin():Number
		{
			return Number(_textFormat.leftMargin);
		}
		
		/**
		 * 设置或获取所有字符之间均匀分配的空间量.
		 */
		public function set letterSpacing(value:Number):void
		{
			if(this.letterSpacing != value)
			{
				_textFormat.letterSpacing = value;
				this.setTextFormat();
			}
		}
		public function get letterSpacing():Number
		{
			return Number(_textFormat.letterSpacing);
		}
		
		/**
		 * 设置或获取段落的右边距.
		 */
		public function set rightMargin(value:Number):void
		{
			if(this.rightMargin != value)
			{
				_textFormat.rightMargin = value;
				this.setTextFormat();
			}
		}
		public function get rightMargin():Number
		{
			return Number(_textFormat.rightMargin);
		}
		
		/**
		 * 设置或获取文本字段是否可选.
		 */
		public function set selectable(value:Boolean):void
		{
			_textField.selectable = value;
		}
		public function get selectable():Boolean
		{
			return _textField.selectable;
		}
		
		/**
		 * 获取当前所选内容中第一个字符从零开始的字符索引值.
		 */
		public function get selectionBeginIndex():int
		{
			return _textField.selectionBeginIndex;
		}
		
		/**
		 * 获取当前所选内容中最后一个字符从零开始的字符索引值.
		 */
		public function get selectionEndIndex():int
		{
			return _textField.selectionEndIndex;
		}
		
		/**
		 * 设置或获取文本.
		 */
		public function set text(value:String):void
		{
			if(this.text != value)
			{
				_textField.text = value;
				this.setTextFormat();
			}
		}
		public function get text():String
		{
			return _textField.text;
		}
		
		/**
		 * 设置或获取文本颜色.
		 */
		public function set textColor(value:uint):void
		{
			if(this.textColor != value)
			{
				_textFormat.color = value;
				this.setTextFormat();
			}
		}
		public function get textColor():uint
		{
			return uint(_textFormat.color);
		}
		
		/**
		 * 获取交互模式属性.
		 */
		public function get textInteractionMode():String
		{
			return _textField.textInteractionMode;
		}
		
		/**
		 * 设置或获取文本是否带下划线.
		 */
		public function set underline(value:Boolean):void
		{
			if(this.underline != value)
			{
				_textFormat.underline = value;
				this.setTextFormat();
			}
		}
		public function get underline():Boolean
		{
			return Boolean(_textFormat.underline);
		}
		
		/**
		 * 获取组件内部的文本区域对象.
		 */
		hammerc_internal function get textField():TextField
		{
			return _textField;
		}
		
		/**
		 * 获取组件内部的文本格式对象.
		 */
		hammerc_internal function get textFormat():TextFormat
		{
			return _textFormat;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function layout():void
		{
			_textField.width = _width;
			_textField.height = _height;
		}
		
		/**
		 * 设置文本样式.
		 */
		protected function setTextFormat():void
		{
			_textField.setTextFormat(_textFormat);
		}
		
		/**
		 * 将指定的字符串追加到文本字段的文本的末尾.
		 * @param newText 要追加到现有文本末尾的字符串.
		 */
		public function appendText(newText:String):void
		{
			_textField.appendText(newText);
			this.setTextFormat();
		}
		
		/**
		 * 使用指定的内容替换当前所选内容.
		 * @param value 要替换当前所选文本的字符串.
		 */
		public function replaceSelectedText(value:String):void
		{
			_textField.replaceSelectedText(value);
			this.setTextFormat();
		}
		
		/**
		 * 将指定的字符范围替换为指定的内容.
		 * @param beginIndex 替换范围开始位置的从零开始的索引值.
		 * @param endIndex 所需文本范围后面的第一个字符的从零开始的索引位置.
		 * @param newText 要用来替换指定范围字符的文本.
		 */
		public function replaceText(beginIndex:int, endIndex:int, newText:String):void
		{
			_textField.replaceText(beginIndex, endIndex, newText);
			this.setTextFormat();
		}
		
		/**
		 * 将第一个字符和最后一个字符的索引值指定的文本设置为所选内容.
		 * @param beginIndex 所选内容中第一个字符从零开始的索引值.
		 * @param endIndex 所选内容中最后一个字符从零开始的索引值.
		 */
		public function setSelection(beginIndex:int, endIndex:int):void
		{
			_textField.setSelection(beginIndex, endIndex);
		}
	}
}
