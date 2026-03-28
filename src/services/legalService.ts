import { Linking } from 'react-native';
import Constants from 'expo-constants';

export type LegalLinks = {
  privacyUrl: string;
  termsUrl: string;
};

function getExtraValue(key: string): string {
  const expoConfig = Constants.expoConfig ?? Constants.manifest;
  const extra = (expoConfig as any)?.extra ?? {};
  return (extra?.[key] as string) ?? '';
}

export function getLegalLinks(): LegalLinks {
  return {
    privacyUrl: getExtraValue('LEGAL_PRIVACY_URL') || 'https://example.com/privacy',
    termsUrl: getExtraValue('LEGAL_TERMS_URL') || 'https://example.com/terms',
  };
}

export async function openExternalLink(url: string): Promise<void> {
  const supported = await Linking.canOpenURL(url);
  if (supported) {
    await Linking.openURL(url);
  }
}
