import { Platform } from 'react-native';
import * as StoreReview from 'expo-store-review';
import * as SecureStore from 'expo-secure-store';

const REVIEW_STATE_KEY = 'app_review_state';

type ReviewState = {
  lastPromptedAt: string | null;
  promptCount: number;
};

async function loadState(): Promise<ReviewState> {
  try {
    const raw = await SecureStore.getItemAsync(REVIEW_STATE_KEY);
    if (raw) return JSON.parse(raw) as ReviewState;
  } catch {
    // ignore
  }
  return { lastPromptedAt: null, promptCount: 0 };
}

async function saveState(state: ReviewState): Promise<void> {
  await SecureStore.setItemAsync(REVIEW_STATE_KEY, JSON.stringify(state));
}

/**
 * Request an in-app review if conditions are met:
 * - Native platform (iOS/Android)
 * - StoreReview is available
 * - Not prompted in the last 90 days
 * - Maximum 3 prompts total
 *
 * Call this at a positive moment (e.g. after completing a key action).
 */
export async function maybeRequestReview(): Promise<boolean> {
  if (Platform.OS === 'web') return false;

  const isAvailable = await StoreReview.isAvailableAsync();
  if (!isAvailable) return false;

  const state = await loadState();

  if (state.promptCount >= 3) return false;

  if (state.lastPromptedAt) {
    const daysSince =
      (Date.now() - new Date(state.lastPromptedAt).getTime()) / (1000 * 60 * 60 * 24);
    if (daysSince < 90) return false;
  }

  await StoreReview.requestReview();

  await saveState({
    lastPromptedAt: new Date().toISOString(),
    promptCount: state.promptCount + 1,
  });

  return true;
}
