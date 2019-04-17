{-# language Strict #-}
{-# language CPP #-}
{-# language PatternSynonyms #-}

module Graphics.Vulkan.C.Core11.Version
  ( pattern VK_API_VERSION_1_1
  ) where

import Data.Word
  ( Word32
  )


import Graphics.Vulkan.C.Core10.Version
  ( pattern VK_MAKE_VERSION
  )


-- | VK_API_VERSION_1_1 - Return API version number for Vulkan 1.1
--
-- = See Also
--
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkCreateInstance',
-- 'Graphics.Vulkan.C.Core10.DeviceInitialization.vkGetPhysicalDeviceProperties'
pattern VK_API_VERSION_1_1 :: Word32
pattern VK_API_VERSION_1_1 = VK_MAKE_VERSION 1 1 0
