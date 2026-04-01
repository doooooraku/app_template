/**
 * Example feature screen — demonstrates the vertical slice pattern.
 *
 * Each feature lives in its own directory under src/features/:
 *   src/features/<feature>/
 *     ├── <Feature>Screen.tsx    — screen component (entry point)
 *     ├── components/            — feature-specific components
 *     ├── hooks/                 — feature-specific hooks
 *     └── utils/                 — feature-specific helpers
 *
 * Wire this into your router at app/(tabs)/example.tsx:
 *   import ExampleScreen from '@/src/features/example/ExampleScreen';
 *   export default ExampleScreen;
 */
import { Text, YStack } from 'tamagui';

import { useTranslation } from '@/src/core/i18n/i18n';

export default function ExampleScreen() {
  const { t } = useTranslation();

  return (
    <YStack flex={1} alignItems="center" justifyContent="center" padding="$4">
      <Text fontSize="$6" fontWeight="bold">
        {t('settings')}
      </Text>
    </YStack>
  );
}
