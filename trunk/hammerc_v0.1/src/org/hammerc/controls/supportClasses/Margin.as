/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls.supportClasses
{
	/**
	 * <code>Margin</code> 类记录组件内部会根据组件尺寸发生尺寸改变的显示对象相对于组件的外边距.
	 * @author wizardc
	 */
	public class Margin
	{
		/**
		 * 记录上边距.
		 */
		protected var _top:Number;
		
		/**
		 * 记录下边距.
		 */
		protected var _bottom:Number;
		
		/**
		 * 记录左边距.
		 */
		protected var _left:Number;
		
		/**
		 * 记录右边距.
		 */
		protected var _right:Number;
		
		/**
		 * 创建一个 <code>Margin</code> 对象.
		 * @param top 上边距.
		 * @param bottom 下边距.
		 * @param left 左边距.
		 * @param right 右边距.
		 */
		public function Margin(top:Number = 0, bottom:Number = 0, left:Number = 0, right:Number = 0)
		{
			this.top = top;
			this.bottom = bottom;
			this.left = left;
			this.right = right;
		}
		
		/**
		 * 设置或获取上边距.
		 */
		public function set top(value:Number):void
		{
			_top = value < 0 ? 0 : value;
		}
		public function get top():Number
		{
			return _top;
		}
		
		/**
		 * 设置或获取下边距.
		 */
		public function set bottom(value:Number):void
		{
			_bottom = value < 0 ? 0 : value;
		}
		public function get bottom():Number
		{
			return _bottom;
		}
		
		/**
		 * 设置或获取左边距.
		 */
		public function set left(value:Number):void
		{
			_left = value < 0 ? 0 : value;
		}
		public function get left():Number
		{
			return _left;
		}
		
		/**
		 * 设置或获取右边距.
		 */
		public function set right(value:Number):void
		{
			_right = value < 0 ? 0 : value;
		}
		public function get right():Number
		{
			return _right;
		}
		
		/**
		 * 获取本对象的一个副本.
		 * @return 本对象的一个副本.
		 */
		public function clone():Margin
		{
			return new Margin(this.top, this.bottom, this.left, this.right);
		}
		
		/**
		 * 获取本对象的字符串描述.
		 * @return 本对象的字符串描述.
		 */
		public function toString():String
		{
			return "[Margin: (top:" + _top + ", bottom:" + _bottom + ", left:" + _left + ", right:" + _right + ")]";
		}
	}
}
