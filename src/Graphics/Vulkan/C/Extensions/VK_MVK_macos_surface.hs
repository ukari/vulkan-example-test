{-# language Strict #-}
{-# language CPP #-}
{-# language GeneralizedNewtypeDeriving #-}
{-# language PatternSynonyms #-}
{-# language DuplicateRecordFields #-}
{-# language DataKinds #-}
{-# language TypeOperators #-}
{-# language OverloadedStrings #-}

module Graphics.Vulkan.C.Extensions.VK_MVK_macos_surface
  ( VkMacOSSurfaceCreateFlagsMVK(..)
  , VkMacOSSurfaceCreateInfoMVK(..)
#if defined(EXPOSE_STATIC_EXTENSION_COMMANDS)
  , vkCreateMacOSSurfaceMVK
#endif
  , FN_vkCreateMacOSSurfaceMVK
  , PFN_vkCreateMacOSSurfaceMVK
  , pattern VK_MVK_MACOS_SURFACE_EXTENSION_NAME
  , pattern VK_MVK_MACOS_SURFACE_SPEC_VERSION
  , pattern VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK
  ) where

import Data.Bits
  ( Bits
  , FiniteBits
  )
import Data.String
  ( IsString
  )
import Foreign.Ptr
  ( FunPtr
  , Ptr
  , plusPtr
  )
import Foreign.Storable
  ( Storable
  , Storable(..)
  )
import GHC.Read
  ( choose
  , expectP
  )
import Text.ParserCombinators.ReadPrec
  ( (+++)
  , prec
  , step
  )
import Text.Read
  ( Read(..)
  , parens
  )
import Text.Read.Lex
  ( Lexeme(Ident)
  )


import Graphics.Vulkan.C.Core10.Core
  ( VkResult(..)
  , VkStructureType(..)
  , Zero(..)
  , VkFlags
  )
import Graphics.Vulkan.C.Core10.DeviceInitialization
  ( VkAllocationCallbacks(..)
  , VkInstance
  )
import Graphics.Vulkan.C.Extensions.VK_KHR_surface
  ( VkSurfaceKHR
  )
import Graphics.Vulkan.NamedType
  ( (:::)
  )


-- ** VkMacOSSurfaceCreateFlagsMVK

-- No documentation found for TopLevel "VkMacOSSurfaceCreateFlagsMVK"
newtype VkMacOSSurfaceCreateFlagsMVK = VkMacOSSurfaceCreateFlagsMVK VkFlags
  deriving (Eq, Ord, Storable, Bits, FiniteBits, Zero)

instance Show VkMacOSSurfaceCreateFlagsMVK where
  
  showsPrec p (VkMacOSSurfaceCreateFlagsMVK x) = showParen (p >= 11) (showString "VkMacOSSurfaceCreateFlagsMVK " . showsPrec 11 x)

instance Read VkMacOSSurfaceCreateFlagsMVK where
  readPrec = parens ( choose [ 
                             ] +++
                      prec 10 (do
                        expectP (Ident "VkMacOSSurfaceCreateFlagsMVK")
                        v <- step readPrec
                        pure (VkMacOSSurfaceCreateFlagsMVK v)
                        )
                    )


-- | VkMacOSSurfaceCreateInfoMVK - Structure specifying parameters of a newly
-- created macOS surface object
--
-- == Valid Usage (Implicit)
--
-- = See Also
--
-- No cross-references are available
data VkMacOSSurfaceCreateInfoMVK = VkMacOSSurfaceCreateInfoMVK
  { -- | @sType@ /must/ be @VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK@
  vkSType :: VkStructureType
  , -- | @pNext@ /must/ be @NULL@
  vkPNext :: Ptr ()
  , -- | @flags@ /must/ be @0@
  vkFlags :: VkMacOSSurfaceCreateFlagsMVK
  , -- | @pView@ /must/ be a valid @NSView@ and /must/ be backed by a @CALayer@
  -- instance of type
  -- 'Graphics.Vulkan.C.Extensions.VK_EXT_metal_surface.CAMetalLayer'.
  vkPView :: Ptr ()
  }
  deriving (Eq, Show)

instance Storable VkMacOSSurfaceCreateInfoMVK where
  sizeOf ~_ = 32
  alignment ~_ = 8
  peek ptr = VkMacOSSurfaceCreateInfoMVK <$> peek (ptr `plusPtr` 0)
                                         <*> peek (ptr `plusPtr` 8)
                                         <*> peek (ptr `plusPtr` 16)
                                         <*> peek (ptr `plusPtr` 24)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkMacOSSurfaceCreateInfoMVK))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkMacOSSurfaceCreateInfoMVK))
                *> poke (ptr `plusPtr` 16) (vkFlags (poked :: VkMacOSSurfaceCreateInfoMVK))
                *> poke (ptr `plusPtr` 24) (vkPView (poked :: VkMacOSSurfaceCreateInfoMVK))

instance Zero VkMacOSSurfaceCreateInfoMVK where
  zero = VkMacOSSurfaceCreateInfoMVK zero
                                     zero
                                     zero
                                     zero
#if defined(EXPOSE_STATIC_EXTENSION_COMMANDS)
-- | vkCreateMacOSSurfaceMVK - Create a VkSurfaceKHR object for a macOS
-- NSView
--
-- = Parameters
--
-- -   @instance@ is the instance with which to associate the surface.
--
-- -   @pCreateInfo@ is a pointer to an instance of the
--     'VkMacOSSurfaceCreateInfoMVK' structure containing parameters
--     affecting the creation of the surface object.
--
-- -   @pAllocator@ is the allocator used for host memory allocated for the
--     surface object when there is no more specific allocator available
--     (see
--     <https://www.khronos.org/registry/vulkan/specs/1.0-extensions/html/vkspec.html#memory-allocation Memory Allocation>).
--
-- -   @pSurface@ points to a
--     'Graphics.Vulkan.C.Extensions.VK_KHR_surface.VkSurfaceKHR' handle in
--     which the created surface object is returned.
--
-- == Valid Usage (Implicit)
--
-- -   @instance@ /must/ be a valid @VkInstance@ handle
--
-- -   @pCreateInfo@ /must/ be a valid pointer to a valid
--     @VkMacOSSurfaceCreateInfoMVK@ structure
--
-- -   If @pAllocator@ is not @NULL@, @pAllocator@ /must/ be a valid
--     pointer to a valid @VkAllocationCallbacks@ structure
--
-- -   @pSurface@ /must/ be a valid pointer to a @VkSurfaceKHR@ handle
--
-- == Return Codes
--
-- [<https://www.khronos.org/registry/vulkan/specs/1.0-extensions/html/vkspec.html#fundamentals-successcodes Success>]
--     -   @VK_SUCCESS@
--
-- [<https://www.khronos.org/registry/vulkan/specs/1.0-extensions/html/vkspec.html#fundamentals-errorcodes Failure>]
--     -   @VK_ERROR_OUT_OF_HOST_MEMORY@
--
--     -   @VK_ERROR_OUT_OF_DEVICE_MEMORY@
--
--     -   @VK_ERROR_NATIVE_WINDOW_IN_USE_KHR@
--
-- = See Also
--
-- No cross-references are available
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkCreateMacOSSurfaceMVK" vkCreateMacOSSurfaceMVK :: ("instance" ::: VkInstance) -> ("pCreateInfo" ::: Ptr VkMacOSSurfaceCreateInfoMVK) -> ("pAllocator" ::: Ptr VkAllocationCallbacks) -> ("pSurface" ::: Ptr VkSurfaceKHR) -> IO VkResult

#endif
type FN_vkCreateMacOSSurfaceMVK = ("instance" ::: VkInstance) -> ("pCreateInfo" ::: Ptr VkMacOSSurfaceCreateInfoMVK) -> ("pAllocator" ::: Ptr VkAllocationCallbacks) -> ("pSurface" ::: Ptr VkSurfaceKHR) -> IO VkResult
type PFN_vkCreateMacOSSurfaceMVK = FunPtr FN_vkCreateMacOSSurfaceMVK
-- No documentation found for TopLevel "VK_MVK_MACOS_SURFACE_EXTENSION_NAME"
pattern VK_MVK_MACOS_SURFACE_EXTENSION_NAME :: (Eq a ,IsString a) => a
pattern VK_MVK_MACOS_SURFACE_EXTENSION_NAME = "VK_MVK_macos_surface"
-- No documentation found for TopLevel "VK_MVK_MACOS_SURFACE_SPEC_VERSION"
pattern VK_MVK_MACOS_SURFACE_SPEC_VERSION :: Integral a => a
pattern VK_MVK_MACOS_SURFACE_SPEC_VERSION = 2
-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK"
pattern VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK :: VkStructureType
pattern VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK = VkStructureType 1000123000
