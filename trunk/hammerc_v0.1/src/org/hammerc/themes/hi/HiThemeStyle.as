/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi
{
	import flash.filters.DropShadowFilter;
	
	/**
	 * 
	 * @author wizardc
	 */
	public class HiThemeStyle
	{
		/**
		 * 
		 */
		public static var DROP_SHADOW:uint = 0x000000;
		
		/**
		 * 
		 */
		public static var PANEL_BORDER:uint = 0xcccccc;
		
		/**
		 * 
		 */
		public static var PANEL_BACKGROUND:uint = 0xf3f3f3;
		
		/**
		 * 
		 */
		public static var LABEL_TEXT:uint = 0x666666;
		
		/**
		 * 
		 */
		public static var INPUT_TEXT:uint = 0x333333;
		
		/**
		 * 
		 */
		public static var TEXT_BACKGROUND:uint = 0xffffff;
		
		/**
		 * 
		 */
		public static var BUTTON_BORDER:uint = 0x999999;
		
		/**
		 * 
		 */
		public static var INPUT_SELECT_BORDER:uint = 0xaaaaaa;
		
		/**
		 * 
		 */
		public static var BUTTON_FACE:uint = 0xffffff;
		
		/**
		 * 
		 */
		public static var BACKGROUND:uint = 0xcccccc;
		
		/**
		 * 
		 * @param dist 
		 * @param knockout 
		 * @return 
		 */
		public static function getShadow(dist:Number, knockout:Boolean = false):DropShadowFilter
		{
			return new DropShadowFilter(dist, 45, DROP_SHADOW, 1, dist, dist, .3, 1, knockout);
		}
	}
}
