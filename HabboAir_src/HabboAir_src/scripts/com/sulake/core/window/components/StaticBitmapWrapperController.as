package com.sulake.core.window.components
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.UnknownICoreAssets1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class StaticBitmapWrapperController extends BitmapDataController implements IStaticBitmapWrapperWindow, UnknownICoreWindowUtils4, UnknownICoreAssets1
   {
      protected var _assetUri:String;
      
      protected var _bitmapDataOwned:Boolean = false;
      
      public function StaticBitmapWrapperController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            if(_bitmapDataOwned)
            {
               _bitmapData.dispose();
            }
            super.dispose();
         }
      }
      
      public function get assetUri() : String
      {
         return _assetUri;
      }
      
      public function set assetUri(param1:String) : void
      {
         if(_assetUri == param1)
         {
            return;
         }
         _assetUri = param1;
         if(param1 == null || param1.length <= 0)
         {
            if(_bitmapDataOwned)
            {
               _bitmapData.dispose();
            }
            _bitmapData = null;
            _bitmapDataOwned = false;
            _context.invalidate(this,null,1);
         }
         else
         {
            _context.getResourceManager().retrieveAsset(_assetUri,this);
         }
      }
      
      public function receiveAsset(param1:ISoundAsset, param2:String) : void
      {
         var _loc5_:Rectangle = null;
         if(_disposed || !_context.getResourceManager().isSameAsset(_assetUri,param2))
         {
            return;
         }
         var _loc4_:BitmapDataAsset = param1 as BitmapDataAsset;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:BitmapData = _loc4_.content as BitmapData;
         if(_loc3_ == null)
         {
            return;
         }
         if(_bitmapData != _loc3_)
         {
            if(_bitmapDataOwned)
            {
               _bitmapData.dispose();
            }
            _bitmapDataOwned = false;
            _loc5_ = _loc4_.rectangle;
            if(_loc3_.width == _loc5_.width && _loc3_.height == _loc5_.height)
            {
               _bitmapData = _loc3_;
            }
            else
            {
               _bitmapData = new BitmapData(_loc5_.width,_loc5_.height);
               _bitmapData.copyPixels(_loc3_,_loc5_,new Point(0,0));
               _bitmapDataOwned = true;
            }
            _context.invalidate(this,null,1);
         }
         fitSize();
      }
      
      override public function clone() : IWindowModel
      {
         var _loc1_:StaticBitmapWrapperController = super.clone() as StaticBitmapWrapperController;
         if(_bitmapDataOwned)
         {
            _loc1_._bitmapData = _bitmapData.clone();
         }
         else
         {
            _loc1_._bitmapData = _bitmapData;
         }
         _loc1_._assetUri = _assetUri;
         _loc1_._bitmapDataOwned = _bitmapDataOwned;
         return _loc1_;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.unshift(createProperty("asset_uri",_assetUri));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("asset_uri" === _loc3_)
            {
               assetUri = _loc2_.value as String;
            }
         }
         super.properties = param1;
      }
   }
}

